import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard functionality

class CopyLink extends StatefulWidget {
  const CopyLink({super.key});

  @override
  State<CopyLink> createState() => _CopyLinkState();
}

class _CopyLinkState extends State<CopyLink> {
  bool isCopied = false;

  void _copyLink() {
    Clipboard.setData(const ClipboardData(text: "https://example.com"));
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
