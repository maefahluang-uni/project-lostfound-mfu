import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostApiHelper {
  static final String? baseUrl = 'http://10.0.2.2:3001/api';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<Map<String, dynamic>> uploadPost({
    required String item,
    required String itemStatus,
    required String date,
    required String time,
    required String location,
    File? imageFile,
    String? color,
    String? phone,
    String? desc,
  }) async {
    String? token = await getToken();
    if (token == null) {
      print("User not authenticated");
      return {};
    }

    var uri = Uri.parse('$baseUrl/posts/upload-post');
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['item'] = item
      ..fields['itemStatus'] = itemStatus
      ..fields['date'] = date
      ..fields['time'] = time
      ..fields['location'] = location;

    if (color != null) request.fields['color'] = color;
    if (phone != null) request.fields['phone'] = phone;
    if (desc != null) request.fields['desc'] = desc;

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('photos', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    } else {
      print("No image selected, skipping image upload.");
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print("Post uploaded successfully");
        return {"success": true, "message": "Post uploaded successfully"};
      } else {
        print("Failed to upload post: ${response.statusCode}");
        return {"success": false, "message": "Failed to upload post"};
      }
    } catch (e) {
      print("Error uploading post: $e");
      return {"success": false, "message": "Error uploading post"};
    }
  }

  static Future<List<Map<String, dynamic>>> getPosts(
      [String? itemStatus]) async {
    String? token = await getToken();
    String itemStatusParam = (itemStatus != null && itemStatus.isNotEmpty)
        ? '?itemStatus=$itemStatus'
        : '';

    try {
      final response = await http.get(
          Uri.parse('$baseUrl/posts/get-posts$itemStatusParam'),
          headers: _headers(token: token));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // print("Response body: ${response.body}");
        List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(data['posts'] ?? []);

        return posts;
      } else {
        print("Failed to fetch posts. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getSinglePost(String postId) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final response = await http.get(
        Uri.parse('$baseUrl/posts/get-single-post/${postId}'),
        headers: _headers(token: token));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load post: ${response.body}");
    }
  }
}
