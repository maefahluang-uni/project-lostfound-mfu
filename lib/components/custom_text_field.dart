import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final double? height;
  final Function(String)? onChanged;
  final int? maxLines;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.label,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.onChanged,
      this.height,
      this.maxLines,
      bool? obscureText,
      TextCapitalization? textCapitalization});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        textAlignVertical: TextAlignVertical.center,
        maxLines: maxLines ?? 1,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            vertical: (height ?? 40),
            horizontal: 20,
          ),
          suffixIcon: Icon(suffixIcon),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          prefixIconColor: AppColor.theme.hintColor,
          labelText: label,
          labelStyle: TextStyle(
            color: AppColor.theme.hintColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
