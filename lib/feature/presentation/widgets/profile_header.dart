import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          // Avatar
          Container(
            height: 64,
            width: 64,

            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18),
            ),

            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // User details
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Althaf',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),

                SizedBox(height: 5),

                Text(
                  'althaf@example.com',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Edit
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
        ],
      ),
    );
  }
}
