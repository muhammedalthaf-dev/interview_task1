import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../domain/entities/product.dart';
import '../pages/product_details_page.dart';
import '../providers/cart_provider.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartItem =
        cartItems.where((item) => item.product.id == product.id).firstOrNull;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    );
                  },
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Price and Add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹${product.price.toStringAsFixed(0)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),

                      // Add to Cart Button / Quantity Stepper
                      if (cartItem == null)
                        InkWell(
                          onTap: () {
                            ref.read(cartProvider.notifier).addToCart(product);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.black,
                                width: 1.2,
                              ),
                            ),
                            child: const Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .decrementQuantity(product.id);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${cartItem.quantity}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .incrementQuantity(product.id);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
