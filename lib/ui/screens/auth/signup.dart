import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/auth/login.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';

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
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Logo.png",
                      width: 100, height: 100),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width *
                        0.9, // Responsive width
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: [
                        const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
                                style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login())),
                              child: const Text("Login",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField(
                                controller: _nameController,
                                label: "Full Name",
                                icon: Icons.person,
                                validator: (value) => value!.isEmpty
                                    ? "Name can't be empty"
                                    : null,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[a-zA-Z\s]+$'))
                                ],
                                textCapitalization: TextCapitalization.words,
                              ),
                              _buildTextField(
                                controller: _emailController,
                                label: "Email",
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Email can't be empty";
                                  final emailRegex = RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                  return emailRegex.hasMatch(value)
                                      ? null
                                      : "Enter a valid email";
                                },
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              _buildTextField(
                                controller: _passwordController,
                                label: "Password",
                                icon: Icons.lock,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Password can't be empty";
                                  return value.length < 6
                                      ? "Password must be at least 6 characters"
                                      : null;
                                },
                              ),
                              _buildTextField(
                                controller: _confirmPasswordController,
                                label: "Confirm Password",
                                icon: Icons.lock,
                                obscureText: true,
                                validator: (value) =>
                                    value != _passwordController.text
                                        ? "Passwords do not match"
                                        : null,
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                text: "Sign Up",
                                onPressed: _handleSignup,
                              ),
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 20),
                              _buildGoogleSignupButton(),
                              const SizedBox(height: 20),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization? textCapitalization,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            String? errorText;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: controller,
                  label: label,
                  suffixIcon: icon,
                  obscureText: obscureText,
                  inputFormatters: inputFormatters,
                  onChanged: (value) {
                    setState(() {
                      errorText = validator?.call(value);
                    });
                  },
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final response = await UserApiHelper.signUp(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["error"] ?? "Signup Successful"),
          backgroundColor:
              response.containsKey("error") ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (!response.containsKey("error")) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    }
  }

  Widget _buildGoogleSignupButton() {
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
        onPressed: () async {
          final response = await UserApiHelper.signInWithGoogle();
          if (response.containsKey('error')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response['error'].toString())),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Google Sign-In Successful')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        },
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
