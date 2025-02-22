import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_found_mfu/components/common/google_sign_up_button.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/auth/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _nameController,
                                label: "Full Name",
                                validator: (value) => value!.isEmpty
                                    ? "Name can't be empty"
                                    : null,
                                suffixIcon: Icons.person,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]'))
                                ],
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                  controller: _emailController,
                                  label: "Email",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email can't be empty";
                                    }
                                    final emailRegex = RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  },
                                  suffixIcon: Icons.email),
                              SizedBox(height: 20),
                              CustomTextField(
                                controller: _passwordController,
                                label: "Password",
                                suffixIcon: Icons.remove_red_eye,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password can't be empty";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                controller: _confirmPasswordController,
                                label: "Confirm Password",
                                suffixIcon: Icons.remove_red_eye,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Confirm Password can't be empty";
                                  }
                                  if (value != _passwordController.text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              CustomButton(
                                  text: "Sign up",
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final response =
                                          await UserApiHelper.signUp(
                                        _nameController.text.trim(),
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        _confirmPasswordController.text.trim(),
                                      );

                                      if (response.containsKey("error")) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(response["error"])));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Signup Successful")));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()),
                                        );
                                      }
                                    }
                                  }),
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
                              GoogleSignUpButton(),
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

  // Widget _buildGoogleSignUpButton() {
  //   return SizedBox(
  //     width: 300,
  //     height: 50,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           side: BorderSide(color: Colors.grey),
  //         ),
  //       ),
  //       onPressed: () {},
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset("assets/icons/GoogleLogo.png", width: 30, height: 30),
  //           SizedBox(width: 10),
  //           Text("Sign Up with Google",
  //               style: TextStyle(color: Colors.black, fontSize: 16)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
