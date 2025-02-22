import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiHelper {
  static final String? baseUrl = 'http://localhost:3001/api';

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
  static Future<Map<String, dynamic>> signUp(String fullName, String email,
      String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return {"error": "Passwords do not match"};
    }

    final url = Uri.parse('$baseUrl/users/signup');

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode(
            {"fullName": fullName, "email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 201) {
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
    final url = Uri.parse('$baseUrl/users/signin');

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (data.containsKey('token')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          return {
            'message': data['message'] ?? 'User signed in successfully',
            'user': data['user']
          };
        } else {
          return {'error': 'Token not found in response. Please try again.'};
        }
      } else {
        return {
          'error':
              data["message"] ?? "Sign-in failed, please check your credentials"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  // Logout
  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      return true;
    } catch (e) {
      return false;
    }
  }

  // Change Password
  static Future<bool> changePassword(
      String oldPassword, String newPassword) async {
    String? token = await getToken();

    try {
      final response = await http.put(Uri.parse('$baseUrl/change-password'),
          headers: _headers(token: token),
          body: jsonEncode(
              {"old_password": oldPassword, "new_password": newPassword}));

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Failed to change password: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error changing password: $e");
      return false;
    }
  }

  static Future<Map<String, String>> getUserProfile() async {
    String? token = await getToken();

    try {
      final response = await http.get(Uri.parse('$baseUrl/user-profile'),
          headers: _headers(token: token));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'name': data['name'] ?? 'Unknown',
          'bio': data['bio'] ?? 'No bio available',
          'profile': data['profile'] ?? 'assets/images/user.jpeg'
        };
      } else {
        print("Failed to fetch profile data: ${response.body}");
        return {};
      }
    } catch (e) {
      print("Error fetching profile data: $e");
      return {};
    }
  }

  static Future<Map<String, String>> updateUserProfile(
    String name,
    String bio,
    String profileImageUrl,
  ) async {
    String? token = await getToken();

    try {
      final response = await http.post(Uri.parse('$baseUrl/update-profile'),
          headers: _headers(token: token),
          body: json.encode({
            'name': name,
            'bio': bio,
            'profile': profileImageUrl,
          }));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to update profile: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print("Error fetching profile data: $e");
      return {};
    }
  }
}
