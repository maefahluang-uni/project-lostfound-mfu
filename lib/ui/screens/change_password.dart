import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordContoller = TextEditingController();
  final _newPasswordContoller = TextEditingController();
  final _confirmNewPasswordContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Scaffold(
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/Logo.png",
                        width: 100,
                        height: 100,
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
                            "Change password",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text("Make sure you remember your password",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                    controller: _oldPasswordContoller,
                                    label: "Old Password",
                                    suffixIcon: Icons.remove_red_eye),
                                SizedBox(height: 20),
                                CustomTextField(
                                    controller: _newPasswordContoller,
                                    label: "New Password",
                                    suffixIcon: Icons.remove_red_eye),
                                SizedBox(height: 20),
                                CustomTextField(
                                    controller: _confirmNewPasswordContoller,
                                    label: "Confirm New Password",
                                    suffixIcon: Icons.remove_red_eye),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: isChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                isChecked = value!;
                                              });
                                            }),
                                        Text("Remember me")
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Forgot Password?",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                CustomButton(
                                    text: "Change Password", onPressed: () {}),
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
      ),
    );
  }
}
