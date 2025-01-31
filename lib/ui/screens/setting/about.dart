import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About the App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "The app is designed to help users (students, staff, and visitors) report and recover lost or found items within the university campus. It aims to create a safe, organized, and user-friendly platform for connecting people who’ve lost items with those who’ve found them. By connecting people who’ve lost items with those who’ve found them, it aims to reduce the hassle and anxiety of losing important belongings on campus. The app also integrates university policies to ensure ethical and transparent handling of lost and found items.",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              "Features",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "- Lost/Found Item Reporting\n"
              "- User Registration & Profile\n"
              "- Item Search & Match System\n"
              "- In-App Messaging\n"
              "- Real-Time Notifications\n"
              "- Item Categories\n",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(height: 10),
            const Text(
              "Contact Information",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "For any inquiries or assistance, feel free to reach out:",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.email, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Email: 6631503061@lamduan.mfu.ac.th",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Phone: +66 (99) 782-0067",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Address: Mae Fah Luang University, Chiang Rai, Thailand",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
