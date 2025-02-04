import 'package:flutter/material.dart';
import 'package:lost_found_mfu/ui/screens/emergency_contacts.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class SosButton extends StatefulWidget {
  const SosButton({super.key});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmergencyContacts()));
      },
      backgroundColor: AppColor.theme.primaryColor,
      child: const Icon(
        Icons.sos_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
