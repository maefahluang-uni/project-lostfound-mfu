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

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.onChanged,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: AppColor.theme.primaryColor.withValues(alpha: 0.2),
                blurRadius: 4,
                spreadRadius: 2,
                offset: const Offset(0, 2))
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: (height ?? 48),
            horizontal: 12,
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
