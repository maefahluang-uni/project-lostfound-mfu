import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/auth/signup.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';

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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: Text("Sign Up",
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
                              SizedBox(height: 10),
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
                              SizedBox(height: 10),
                              CustomButton(
                                  text: "Login",
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final response =
                                          await UserApiHelper.signIn(
                                              _emailController.text.trim(),
                                              _passwordController.text.trim());

                                      if (response.containsKey("error")) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(response["error"])));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Signin Successful")));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()));
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
