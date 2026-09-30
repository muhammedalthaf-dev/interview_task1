import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryHeader extends ConsumerWidget {
  const DeliveryHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nova in',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                ' minutes',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.6,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
            ],
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),

            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile & Settings'),
                    duration: Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 22,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
