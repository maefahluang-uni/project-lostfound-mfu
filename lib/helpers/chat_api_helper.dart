import 'dart:convert';

import 'package:lost_found_mfu/models/chat.dart';
import 'package:lost_found_mfu/models/chat_inbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatApiHelper {
  static final String? baseUrl = "http://10.0.2.2:3001/api";

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
      try{
        final uri = Uri.parse("$baseUrl/chats/get_chats").replace(queryParameters: {
          if (searchQuery != null && searchQuery.isNotEmpty) "searchQuery": searchQuery,
        });

        final response = await http.get(uri, headers: _headers(token: token));
        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<ChatRoom> chatRooms = jsonData.map((json) => ChatRoom.fromJson(json)).toList();
          return chatRooms;
        }
       else {
        print("Failed to fetch posts. Status code: ${response.statusCode}");
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
      final response = await http.get(
        Uri.parse('$baseUrl/chats/get_chat_room/$chatRoomId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return ChatInbox.fromJson(jsonData);
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
    required String message,
    required String receiverId,
    required String chatRoomId,
    required String senderId
  }) async {
    try {
      String? token = await getToken();
      if (token == null) {
        print("User not authenticated");
        return null;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/chats/send_message'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "messageType": messageType,
          "message": message,
          "senderId": senderId,
          "receiverId": receiverId,
          "chatRoomId": chatRoomId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); 
      } else {
        throw Exception("Failed to send message: ${response.body}");
      }
    } catch (error) {
      print("❌ Error sending message: $error");
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
      } else {
        print("Failed to mark messages as read. Status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error marking messages as read: $error");
    }
  }}