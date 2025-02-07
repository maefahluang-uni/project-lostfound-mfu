import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignUpButton extends StatefulWidget {
  const GoogleSignUpButton({super.key});

  @override
  State<GoogleSignUpButton> createState() => _GoogleSignUpButtonState();
}

class _GoogleSignUpButtonState extends State<GoogleSignUpButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignUp() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        print("Google Sign-In successful: ${googleUser.displayName}");
      }
    } catch (error) {
      print("Error during Google Sign-Up: $error");
    }
  }

  @override
  Widget _buildGoogleSignUpButton() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
        ),
        onPressed: _handleGoogleSignUp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/GoogleLogo.png", width: 30, height: 30),
            SizedBox(width: 10),
            Text("Sign Up with Google",
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGoogleSignUpButton();
  }
}
