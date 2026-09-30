import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation_provider.dart';
import '../widgets/bottom_nav_bar.dart';

import 'home_page.dart';
import 'search_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  static const List<Widget> pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: const AppBottomNavBar(),
      backgroundColor: Colors.white,
    );
  }
}
