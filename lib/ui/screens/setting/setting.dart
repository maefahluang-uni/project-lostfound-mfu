import 'package:flutter/material.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/auth/login.dart';
import 'package:lost_found_mfu/ui/screens/setting/about.dart';
import 'package:lost_found_mfu/ui/screens/setting/change_password.dart';
import 'package:lost_found_mfu/ui/screens/setting/terms_policy.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Color _aboutColor = Colors.grey[300]!;
  Color _termsColor = Colors.grey[300]!;
  Color _passwordColor = Colors.grey[300]!;
  Color _logoutColor = Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          buildSettingRow("About", Icons.question_mark_outlined, _aboutColor,
              () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => About()));
          }),
          buildSettingRow(
              "Terms & Policy", Icons.assignment_rounded, _termsColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsPolicy()));
          }),
          buildSettingRow("Change Password", Icons.lock, _passwordColor, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePassword()));
          }),
          buildLogoutButton(),
        ],
      ),
    );
  }

  Widget buildSettingRow(
      String text, IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MouseRegion(
        onEnter: (_) => setState(() => color = Colors.grey[500]!),
        onExit: (_) => setState(() => color = Colors.grey[300]!),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(icon, size: 20, color: Colors.red),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Icon(Icons.arrow_right_alt_outlined, size: 30, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _logoutColor = Colors.grey[500]!),
        onExit: (_) => setState(() => _logoutColor = Colors.grey[300]!),
        child: InkWell(
          onTap: () => _showLogoutDialog(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(Icons.logout_sharp, size: 20, color: Colors.red),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Log out",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFCF2D1E), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel",
                  style: TextStyle(color: Color(0xFFCF2D1E), fontSize: 12)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCF2D1E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => _handleLogout(),
              child: Text("Logout",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    String? token = await UserApiHelper.getToken();
    if (token != null) {
      await UserApiHelper.logout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      print("No token found, logout failed.");
    }
  }
}
