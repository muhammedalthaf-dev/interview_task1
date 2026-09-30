import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:ecommerce_app/feature/presentation/widgets/category_tab_bar.dart';
import 'package:ecommerce_app/feature/presentation/widgets/delivery_header.dart';

class BlinkitAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showTabBar;
  final VoidCallback? onSearchTap;

  const BlinkitAppBar({super.key, this.showTabBar = true, this.onSearchTap});

  @override
  Size get preferredSize => Size.fromHeight(showTabBar ? 250.0 : 138.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradient = ref.watch(categoryGradientProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
          stops: const [0.0, 0.5, 0.82, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: DeliveryHeader(),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onSearchTap,
                      behavior: HitTestBehavior.opaque,
                      child: IgnorePointer(
                        ignoring: onSearchTap != null,
                        child: const AppTextField(
                          hintText: 'Search Your Products',
                          prefixIcon: Icons.search,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 27,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            if (showTabBar) const CategoryTabBar(),

            Container(height: 1, color: Colors.black.withValues(alpha: 0.04)),
          ],
        ),
      ),
    );
  }
}
