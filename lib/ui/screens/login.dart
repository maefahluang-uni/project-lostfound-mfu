import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFCF2D1E), Color(0xFFD45F55)],
          begin: Alignment.topCenter,
        )),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/Logo.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 600,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _emailController,
                                  label: "Email",
                                  suffixIcon: Icons.email),
                              SizedBox(height: 20),
                              CustomTextField(
                                  controller: _passwordController,
                                  label: "Password",
                                  suffixIcon: Icons.remove_red_eye),
                              SizedBox(height: 20),
                              CustomButton(text: "Login", onPressed: () {}),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("Or"),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  )),
                                ],
                              ),
                              SizedBox(height: 20),
                              _buildGoogleLoginButton(),
                              SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton() {
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
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/GoogleLogo.png", width: 30, height: 30),
            SizedBox(width: 10),
            Text("Continue with Google",
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
