import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/cart_provider.dart';

class CartBillSummary extends ConsumerWidget {
  const CartBillSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.watch(cartTotalPriceProvider);
    final deliveryFee = ref.watch(cartDeliveryFeeProvider);
    final savings = ref.watch(cartTotalSavingsProvider);
    final grandTotal = ref.watch(cartGrandTotalProvider);
    const platformFee = 4.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 20,
                color: AppColors.icon,
              ),
              SizedBox(width: 8),
              Text(
                'Bill Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _buildRow('Items Total', '₹${subtotal.toStringAsFixed(0)}'),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Delivery Fee',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              if (deliveryFee == 0)
                const Row(
                  children: [
                    Text(
                      '₹29',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'FREE',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  '₹${deliveryFee.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          _buildRow('Platform Fee', '₹${platformFee.toStringAsFixed(0)}'),

          if (savings > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.savings_outlined,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'You are saving ₹${savings.toStringAsFixed(0)} on this order',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.divider, height: 1),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'To Pay',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '₹${grandTotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
