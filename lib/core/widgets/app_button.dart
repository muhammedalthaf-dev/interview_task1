import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool outlined;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.outlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return SizedBox(
        width: double.infinity,
        height: 54,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
          label: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.black,
            side: const BorderSide(color: AppColors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
