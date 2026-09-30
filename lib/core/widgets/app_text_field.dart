import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: AppColors.black),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
