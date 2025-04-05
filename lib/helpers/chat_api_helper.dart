import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/models/chat.dart';
import 'package:lost_found_mfu/models/chat_inbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ChatApiHelper {
  static final String? baseUrl = dotenv.env['BASE_URL'];

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<List<ChatRoom>> getChatRooms({String? searchQuery}) async {
    String? token = await getToken();
    if (token == null) {
      print("User not authenticated");
      return [];
    }
    try {
      final uri =
          Uri.parse("$baseUrl/chats/get_chats").replace(queryParameters: {
        if (searchQuery != null && searchQuery.isNotEmpty)
          "searchQuery": searchQuery,
      });

      final response = await http.get(uri, headers: _headers(token: token));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<ChatRoom> chatRooms =
            jsonData.map((json) => ChatRoom.fromJson(json)).toList();
        return chatRooms;
      } else {
        if (response.statusCode == 401) {
          await UserApiHelper.forceLogout();
        }
        print("Response body: ${response.body}");
        return [];
      }
    } catch (error) {
      print("Error fetching chat rooms: $error");
      return [];
    }
  }

  static Future<ChatInbox?> getChatRoom(String chatRoomId) async {
    String? token = await getToken();
    if (token == null) {
      print("User not authenticated");
      return null;
    }

    try {
      final response = await http
          .get(Uri.parse('$baseUrl/chats/get_chat_room/$chatRoomId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return ChatInbox.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        await UserApiHelper.forceLogout();
        return null;
      } else {
        print("Failed to fetch chat room. Status: ${response.statusCode}");
        print("Response: ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error fetching chat room: $error");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendChatMessage({
    required String messageType,
    String? message,
    required String receiverId,
    String? chatRoomId,
    required String senderId,
    XFile? file,
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        print("User not authenticated");
        return null;
      }

      var uri = Uri.parse('$baseUrl/chats/send_message');

      if (message != null && file == null) {
        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "messageType": messageType,
            "message": message,
            "senderId": senderId,
            "receiverId": receiverId,
            if (chatRoomId != null) "chatRoomId": chatRoomId,
          }),
        );

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception("Failed to send message: ${response.body}");
        }
      }

      if (file != null && message == null) {
        print("Sending Image...");

        if (await file.length() == 0) {
          print("Error: File is empty, not sending.");
          return null;
        }

        var request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer $token'
          ..fields['messageType'] = messageType
          ..fields['senderId'] = senderId
          ..fields['receiverId'] = receiverId;

        if (chatRoomId != null) {
          request.fields['chatRoomId'] = chatRoomId;
        }

        var fileBytes = await file.readAsBytes();
        var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: file.name,
            contentType: MediaType.parse(mimeType),
          ),
        );

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonDecode(response.body);
        } else {
          throw Exception("Failed to send file: ${response.body}");
        }
      }

      print("Error: No message or file provided.");
      return null;
    } catch (error) {
      print("Error sending chat message: $error");
      return null;
    }
  }

  static Future<void> readChatRoom(String chatRoomId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("User not authenticated");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/chats/read_chat_room/$chatRoomId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        print("Messages marked as read in chat room: $chatRoomId");
      } else if (response.statusCode == 401) {
        await UserApiHelper.forceLogout();
      } else {
        print(
            "Failed to mark messages as read. Status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error marking messages as read: $error");
    }
  }
}
