import 'package:flutter/material.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileLogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,

      icon: const Icon(Icons.logout_rounded),

      label: const Text('Logout'),

      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,

        side: const BorderSide(color: Colors.red),

        padding: const EdgeInsets.symmetric(vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
