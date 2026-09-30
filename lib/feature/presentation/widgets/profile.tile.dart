import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),

            child: Row(
              children: [
                // Icon container
                Container(
                  height: 44,
                  width: 44,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Icon(icon, size: 22, color: Colors.black87),
                ),

                const SizedBox(width: 14),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Arrow
                Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
