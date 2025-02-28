import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
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
      appBar: CustomAppbar(appBarTitle: "Setting", hasBackArrow: true),
      body: Column(
        children: [
          buildSettingRow("About", Icons.question_mark_outlined, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => About()));
          }),
          buildSettingRow("Terms & Policy", Icons.assignment_rounded, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsPolicy()));
          }),
          buildSettingRow("Change Password", Icons.lock, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePassword()));
          }),
          buildAccountDeleteButton(),
          buildLogoutButton(),
        ],
      ),
    );
  }

  Widget buildSettingRow(String text, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
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
    );
  }

  Widget buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: _showLogoutDialog,
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
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog before logout
                _handleLogout();
              },
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
    bool isLoggedOut = await UserApiHelper.logout();
    if (isLoggedOut) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout Successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed. Please try again.")),
      );
    }
  }

  Widget buildAccountDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: _showAccountDeleteDialog,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(Icons.warning, size: 20, color: Colors.red),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Delete Account",
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
    );
  }

  Future<void> _showAccountDeleteDialog() async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete Account"),
          content: const Text(
              "Are you sure you want to delete your account? This can be undone."),
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
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog before logout
                _handleDeleteAccount();
              },
              child: Text("Delete",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      _handleDeleteAccount();
    }
  }

  Future<void> _handleDeleteAccount() async {
    bool isDeleteAccount = await UserApiHelper.deleteUser();
    if (isDeleteAccount) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Deleted Successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Delete account failed. Please try again.")),
      );
    }
  }
}
