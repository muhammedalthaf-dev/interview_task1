import 'package:ecommerce_app/feature/presentation/widgets/profile.tile.dart';
import 'package:ecommerce_app/feature/presentation/widgets/profile_titile.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_header.dart';

import '../widgets/profile_logout_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final horizontalPadding = width >= 600 ? 40.0 : 16.0;

    final maxWidth = width >= 900 ? 700.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              children: [
                const ProfileHeader(),

                const SizedBox(height: 24),

                const ProfileSectionTitle(title: 'Account'),

                const SizedBox(height: 10),

                ProfileTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Personal Information',
                  subtitle: 'Manage your account details',
                  onTap: () {},
                ),

                ProfileTile(
                  icon: Icons.location_on_outlined,
                  title: 'Saved Addresses',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {},
                ),

                ProfileTile(
                  icon: Icons.favorite_border_rounded,
                  title: 'Wishlist',
                  subtitle: 'View your saved products',
                  onTap: () {},
                ),

                const SizedBox(height: 24),

                const ProfileSectionTitle(title: 'Orders'),

                const SizedBox(height: 10),

                ProfileTile(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  subtitle: 'View your order history',
                  onTap: () {},
                ),

                ProfileTile(
                  icon: Icons.local_shipping_outlined,
                  title: 'Track Order',
                  subtitle: 'Track your current orders',
                  onTap: () {},
                ),

                const SizedBox(height: 24),

                const ProfileSectionTitle(title: 'Settings'),

                const SizedBox(height: 10),

                ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Manage notifications',
                  onTap: () {},
                ),

                ProfileTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  subtitle: 'Get help with your orders',
                  onTap: () {},
                ),

                ProfileTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About',
                  subtitle: 'App information',
                  onTap: () {},
                ),

                const SizedBox(height: 28),

                ProfileLogoutButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'Ecommerce App',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 6),

                const Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
