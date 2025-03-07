import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
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
                                controller: _oldPasswordController,
                                label: "Old Password",
                                suffixIcon: Icons.remove_red_eye,
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                controller: _newPasswordController,
                                label: "New Password",
                                suffixIcon: Icons.remove_red_eye,
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                controller: _confirmNewPasswordController,
                                label: "Confirm New Password",
                                suffixIcon: Icons.remove_red_eye,
                                obscureText: true,
                              ),
                              SizedBox(height: 10),
                              // Row(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Checkbox(
                              //             value: isChecked,
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 isChecked = value!;
                              //               });
                              //             }),
                              //         Text("Remember me")
                              //       ],
                              //     ),
                              //     SizedBox(
                              //       width: 30,
                              //     ),
                              //     Text(
                              //       "Forgot Password?",
                              //       style: TextStyle(fontSize: 14),
                              //     )
                              //   ],
                              // ),
                              SizedBox(height: 20),
                              CustomButton(
                                  text: "Change Password",
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // ignore: unused_local_variable
                                      String oldPassword =
                                          _oldPasswordController.text;
                                      String newPassword =
                                          _newPasswordController.text;
                                      String confirmNewPassword =
                                          _confirmNewPasswordController.text;

                                      if (newPassword != confirmNewPassword) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "New passwords do not match!")));
                                        return;
                                      }

                                      bool success =
                                          await UserApiHelper.changePassword(
                                              oldPassword, newPassword);
                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Password changed successfully!")),
                                        );
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Failed to change password!")),
                                        );
                                      }
                                    }
                                  }),
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

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }
}
