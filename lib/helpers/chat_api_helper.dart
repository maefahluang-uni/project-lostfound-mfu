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

  static Future<List<ChatRoom>> getChatRooms() async {
      String? token = await getToken();
      if (token == null) {
        print("User not authenticated");
        return [];
      }
      try{
        final response = await http.get(
          Uri.parse('$baseUrl/chats/get_chats'),
          headers: _headers(token: token));
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
}