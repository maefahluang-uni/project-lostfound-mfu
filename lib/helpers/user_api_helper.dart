import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiHelper {
  static const String baseUrl = "";

  // Get token from shared preferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Common headers for API requests
  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // Sign up
  static Future<Map<String, dynamic>> signUp(String name, String email,
      String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return {"error": "Passwords do not match"};
    }

    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      } else {
        return {"error": data["message"] ?? "Signup failed, please try again"};
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  // Sign in
  static Future<Map<String, dynamic>> signIn(
      String email, String password) async {
    final url = Uri.parse('$baseUrl/signin');

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data.containsKey('token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return data;
      } else {
        return {
          "error":
              data["message"] ?? "Sign-in failed, please check your credentials"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await getToken();
    if (token == null) return;

    final url = Uri.parse('$baseUrl/logout');

    try {
      await http.post(url, headers: _headers(token: token));
      await prefs.remove('token');
    } catch (e) {
      debugPrint("Logout failed: $e");
    }
  }
}
