import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_bill_summary.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/empty_cart_widget.dart';

import 'checkout_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  void _confirmClearCart(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear Cart'),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clearCart();
              Navigator.pop(ctx);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalCount = ref.watch(cartTotalCountProvider);
    final grandTotal = ref.watch(cartGrandTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          totalCount > 0 ? 'My Cart ($totalCount)' : 'My Cart',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton.icon(
              onPressed: () => _confirmClearCart(context, ref),
              icon: const Icon(
                Icons.delete_sweep_outlined,
                size: 18,
                color: Colors.redAccent,
              ),
              label: const Text(
                'Clear',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? const EmptyCartWidget()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fast Delivery Banner
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9C4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFFE082)),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.electric_bolt_rounded,
                          color: Color(0xFFF57F17),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Superfast Delivery in 10-15 minutes',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart Items List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemTile(item: cartItems[index]);
                    },
                  ),

                  // Coupon Card
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.discount_outlined,
                            color: Colors.orange,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WELCOME20 Applied',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Special welcome discount included',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 20,
                        ),
                      ],
                    ),
                  ),

                  // Bill Summary
                  const CartBillSummary(),

                  // Cancellation policy note
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: AppColors.iconMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Orders once placed cannot be cancelled after dispatch. Please review items before proceeding.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Payable',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '₹${grandTotal.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutPage(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to Pay',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
