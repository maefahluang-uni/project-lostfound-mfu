import 'package:flutter/material.dart';

class TermsPolicy extends StatefulWidget {
  const TermsPolicy({super.key});

  @override
  State<TermsPolicy> createState() => _TermsPolicyState();
}

class _TermsPolicyState extends State<TermsPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms & Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "1. Purpose",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "This app helps users report, find, and return lost items in a safe and organized way. It connects those who have lost items with those who find them.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "2. User Responsibilities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- Provide accurate and honest information about lost or found items.\n"
              "- Treat others respectfully and responsibly during communication and item exchanges.\n"
              "- Do not post fraudulent claims or misuse the app.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "3. Privacy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- Data Collected: Name, contact details, and item descriptions.\n"
              "- Data Use: Information is used only to connect users for item recovery and improve app functionality.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "4. Code of Conduct",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- No harassment, abusive language, or illegal activities are allowed.\n"
              "- Violators may be banned from using the app.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
