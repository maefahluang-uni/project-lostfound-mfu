import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostApiHelper {
  static final String? baseUrl = 'http://localhost:3001/api';

  // Get token from shared preferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Get UserId from shared preferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Common headers for API requests
  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // Post post
  static Future<Map<String, dynamic>> uploadPost({
    required String item,
    required String itemStatus,
    required String date,
    String? time,
    String? location,
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

    var url = Uri.parse('$baseUrl/posts/upload-post');
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['item'] = item
      ..fields['itemStatus'] = itemStatus
      ..fields['date'] = date;

    if (time != null) request.fields['time'] = time;
    if (location != null) request.fields['location'] = location;
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
      final byteData = await rootBundle.load('assets/images/macbook.jpg');
      final imageBytes = byteData.buffer.asUint8List();

      var stream = http.ByteStream.fromBytes(imageBytes);
      var length = imageBytes.length;
      var multipartFile =
          http.MultipartFile('photos', stream, length, filename: 'macbook.jpg');
      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print("Post uploaded successfully");
        return {"success": true, "message": "Post uploaded successfully"};
      } else {
        var responseBody = await response.stream.bytesToString();
        print(
            "Failed to upload post: ${response.statusCode}, Response: $responseBody");
        return {"success": false, "message": "Failed to upload post"};
      }
    } catch (e) {
      print("Error uploading post: $e");
      return {"success": false, "message": "Error uploading post"};
    }
  }

  // Get Posts
  static Future<List<Map<String, dynamic>>> getPosts(
      {String? itemStatus, String? search}) async {
    String? token = await getToken();

    Map<String, String> queryParams = {};
    if (itemStatus != null && itemStatus.isNotEmpty) {
      queryParams['itemStatus'] = itemStatus;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    String queryString = Uri(queryParameters: queryParams).query;
    String url =
        '$baseUrl/posts/get-posts${queryString.isNotEmpty ? '?$queryString' : ''}';

    try {
      final response =
          await http.get(Uri.parse(url), headers: _headers(token: token));

      if (response.statusCode == 401) {
        await UserApiHelper.logout();
        return [];
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(data['posts'] ?? []);

        return posts;
      } else if (response.statusCode == 401) {
        await UserApiHelper.forceLogout();
        return [];
      } else {
        print("Failed to fetch posts. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    }
  }

  // Get Post
  static Future<Map<String, dynamic>> getSinglePost(String postId) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final url = Uri.parse('$baseUrl/posts/get-single-post/${postId}');
    final response = await http.get(url, headers: _headers(token: token));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load post: ${response.body}");
    }
  }

  // Share Post
  static Future<Map<String, dynamic>> getSharePost(String postId) async {
    final url = Uri.parse('$baseUrl/posts/get-single-post/${postId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load post: ${response.body}");
    }
  }

  // Update Post
  static Future<Map<String, dynamic>> editPost({
    required String postId,
    required String item,
    required String itemStatus,
    required String date,
    String? time,
    String? location,
    File? imageFile,
    String? color,
    String? phone,
    String? desc,
  }) async {
    String? token = await getToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    var uri = Uri.parse('$baseUrl/posts/edit-post/$postId');
    var request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['item'] = item
      ..fields['itemStatus'] = itemStatus
      ..fields['date'] = date;

    if (time != null) request.fields['time'] = time;
    if (location != null) request.fields['location'] = location;
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
      if (response.statusCode == 200) {
        print("Post updated successfully");
        return {"success": true, "message": "Post updated successfully"};
      } else {
        print("Failed to update post: ${response.statusCode}");
        return {"success": false, "message": "Failed to update post"};
      }
    } catch (e) {
      print("Error updating post: $e");
      return {"success": false, "message": "Error updating post"};
    }
  }

  // Delete Post
  static Future<Map<String, dynamic>> deletePost(String postId) async {
    String? token = await getToken();
    if (token == null) {
      print("User not authenticated");
      return {};
    }

    final url = Uri.parse(
      '$baseUrl/posts/delete-post/$postId',
    );
    final response = await http.delete(url, headers: _headers(token: token));

    if (response.statusCode == 200) {
      return {"success": true, "message": "Post deleted successfully"};
    } else {
      return {"success": false, "message": "Failed to delete post"};
    }
  }
}
