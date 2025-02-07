import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiHelper {
  static const String baseUrl = "";

  // Sign up
  static Future<Map<String, dynamic>> signUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      return {"error": "Passwords do not match"};
    }
    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"name": name, "email": email, "password": password}));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Signup failed, please try again"};
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  // Sign in
  static Future<Map<String, dynamic>> signIn(
    String email,
    String password,
  ) async {
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      return {"error": "Invalid email format"};
    }

    if (password.isEmpty) {
      return {"error": "Password cannot be empty"};
    }

    final url = Uri.parse('$baseUrl/signin');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Sign-in failed, please check your credentials"};
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }
}
