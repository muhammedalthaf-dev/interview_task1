import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/cart_provider.dart';
import '../providers/navigation_provider.dart';

class AppBottomNavBar extends ConsumerWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);
    final cartCount = ref.watch(cartTotalCountProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      height: 68,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            index: 0,
            selectedIndex: selectedIndex,
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            onTap: () => _changeTab(ref, 0),
          ),

          _NavItem(
            index: 1,
            selectedIndex: selectedIndex,
            label: 'Search',
            icon: Icons.search_outlined,
            selectedIcon: Icons.search_rounded,
            onTap: () => _changeTab(ref, 1),
          ),

          _NavItem(
            index: 2,
            selectedIndex: selectedIndex,
            label: 'Cart',
            icon: Icons.shopping_cart_outlined,
            selectedIcon: Icons.shopping_cart_rounded,
            badgeCount: cartCount,
            onTap: () => _changeTab(ref, 2),
          ),

          _NavItem(
            index: 3,
            selectedIndex: selectedIndex,
            label: 'Profile',
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            onTap: () => _changeTab(ref, 3),
          ),
        ],
      ),
    );
  }

  void _changeTab(WidgetRef ref, int index) {
    ref.read(navigationIndexProvider.notifier).state = index;
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSelected ? selectedIcon : icon,
                    key: ValueKey(isSelected),
                    size: 24,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.iconMuted,
                  ),
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: -4,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        badgeCount > 99 ? '99+' : '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 3),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
