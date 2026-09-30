import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/cart_provider.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 72,
              height: 72,
              color: AppColors.surfaceSecondary,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.iconMuted,
                  size: 28,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (product.brand.isNotEmpty)
                  Text(
                    product.brand.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '₹${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '₹${(product.price * 1.25).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    ref
                        .read(cartProvider.notifier)
                        .decrementQuantity(product.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      item.quantity == 1
                          ? Icons.delete_outline_rounded
                          : Icons.remove,
                      size: 16,
                      color: item.quantity == 1
                          ? Colors.redAccent
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    ref
                        .read(cartProvider.notifier)
                        .incrementQuantity(product.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
