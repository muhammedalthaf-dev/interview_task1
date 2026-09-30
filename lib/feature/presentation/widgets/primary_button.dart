import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';

/// Primary action button styled with the distinctive brand green and rounded corners.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.black,
        foregroundColor: textColor ?? Colors.white,
        disabledBackgroundColor: (backgroundColor ?? AppColors.black)
            .withValues(alpha: 0.6),
        elevation: 0,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor ?? Colors.white,
              ),
            ),
    );
  }
}
