import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:lost_found_mfu/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserApiHelper {
  static final String? baseUrl = dotenv.env['BASE_URL'];
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  // Get token from shared preferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Get userId from shared preferences
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

    String? fcmToken;
    if (Platform.isAndroid) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      print("FCM Token (Android): $fcmToken");
    } else {
      print("Skipping FCM Token request on iOS.");
    }

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    if (fcmToken != null && fcmToken.isNotEmpty) {
      requestBody["fcmToken"] = fcmToken;
    }

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode(requestBody),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (data.containsKey('token')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          await prefs.setString('userId', data['user']['userId']);
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
    String? userId = await getUserId();

    if (token != null && userId != null) {
      final url = Uri.parse('$baseUrl/users/change-password');

      try {
        final response = await http.post(url,
            headers: _headers(token: token),
            body: jsonEncode({
              "uid": userId,
              "oldPassword": oldPassword,
              "newPassword": newPassword
            }));

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
    } else {
      return false;
    }
  }

  // Get User Data
  static Future<Map<String, dynamic>> getUserProfile() async {
    String? token = await getToken();
    String? userId = await getUserId();

    try {
      final url = Uri.parse('$baseUrl/users/user/$userId');
      final response = await http.get(url, headers: _headers(token: token));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'fullName': data['fullName'] ?? 'Unknown',
          'bio': (data['bio'] != null && data['bio'].isNotEmpty)
              ? data['bio']
              : 'Write Your Bio',
          'profileImage': data['profileImage'] ?? 'assets/images/user.jpeg',
          'posts': data['posts'] ?? []
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

  // Update User Data
  static Future<Map<String, dynamic>> updateUserProfile({
    required String name,
    required String bio,
    required String profileImageUrl,
    required String imagePath, // This is optional for image update
  }) async {
    String? token = await getToken();
    String? userId = await getUserId();

    try {
      final url = Uri.parse('$baseUrl/users/user/$userId');
      final Map<String, String> headers = _headers(token: token);

      if (imagePath.isNotEmpty) {
        var request = http.MultipartRequest('PUT', url);
        request.headers.addAll(headers);

        request.fields['fullName'] = name;
        request.fields['bio'] = bio;

        var imageFile = await http.MultipartFile.fromPath(
          'profileImage', // Field name expected by the API
          imagePath,
        );
        request.files.add(imageFile);

        var response = await request.send();
        if (response.statusCode == 201) {
          print("Profile updated successfully");
          return json.decode(await response.stream.bytesToString());
        } else {
          print('Failed to update profile: ${response.statusCode}');
          return {};
        }
      } else {
        var body = {
          'fullName': name,
          'bio': bio,
        };

        if (profileImageUrl.startsWith('http://') ||
            profileImageUrl.startsWith('https://')) {
          body['profileImage'] =
              profileImageUrl; // Send the URL directly if it's a remote image
        }

        final response =
            await http.put(url, headers: headers, body: json.encode(body));

        if (response.statusCode == 200) {
          print("Profile updated successfully");
          return json.decode(response.body);
        } else {
          print('Failed to update profile: ${response.statusCode}');
          return {};
        }
      }
    } catch (e) {
      print("Error fetching profile data: $e");
      return {};
    }
  }

  // Delete User Data
  static Future<bool> deleteUser() async {
    String? token = await getToken();
    String? userId = await getUserId();

    try {
      final url = Uri.parse("$baseUrl/users/user/$userId");
      final response = await http.delete(url, headers: _headers(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print('Failed to delete account: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error deleting account: $e");
      return true;
    }
  }

  // Sign in with Google
  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return {'error': 'Google sign-in failed'};

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final idToken = googleAuth.idToken;
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (idToken == null) throw Exception("Failed to get idToken");

      final url = Uri.parse("$baseUrl/users/google-signin");
      final response = await http.post(
        url,
        body: jsonEncode({"idToken": idToken, "fcmToken": fcmToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        return {'error': "Failed to authenticate: ${response.body}"};
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return {'error': "Error signing in with Google: $e"};
    }
  }

  // Authenticate with Firebase
  static Future<UserCredential?> authenticateWithFirebase(
      String customToken) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);
      return userCredential;
    } catch (e) {
      print("Firebase Authentication Error: $e");
      return null;
    }
  }

  static Future<void> forceLogout() async {
    await logout();
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
