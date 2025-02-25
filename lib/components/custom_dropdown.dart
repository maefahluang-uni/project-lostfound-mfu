import 'package:flutter/material.dart';

import '../ui/theme/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final List<String> items;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final double? height;
  final Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.items,
    this.label,
    this.validator,
    this.prefixIcon,
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
            color: AppColor.theme.primaryColor.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: DropdownButtonFormField<String>(
        isDense: true,
        value: controller.text.isNotEmpty ? controller.text : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: (height ?? 24) / 2,
            horizontal: 12,
          ),
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
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.text = newValue ?? '';
          onChanged?.call(newValue ?? '');
        },
        validator: validator,
      ),
    );
  }
}
