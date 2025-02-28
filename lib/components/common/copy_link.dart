import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard functionality

class CopyLink extends StatefulWidget {
  final String postId;

  const CopyLink({super.key, required this.postId});

  @override
  State<CopyLink> createState() => _CopyLinkState();
}

class _CopyLinkState extends State<CopyLink> {
  bool isCopied = false;
  static final String? baseUrl = 'http://localhost:3001/api';

  void _copyLink() {
    String postUrl = "https://lost-and-found-in-mfu-service.web.app";
    Clipboard.setData(ClipboardData(text: postUrl));

    setState(() {
      isCopied = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _copyLink,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isCopied ? Icons.check : Icons.copy,
            color: isCopied ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            isCopied ? "Copied!" : "Copy Link",
            style: TextStyle(
              color: isCopied ? Colors.green : Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
