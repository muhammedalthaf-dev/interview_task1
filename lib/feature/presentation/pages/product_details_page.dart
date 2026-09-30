import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/feature/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../domain/entities/product.dart';
import '../providers/cart_provider.dart';
import '../providers/navigation_provider.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;

  List<String> get _images {
    if (widget.product.images.isNotEmpty) {
      return widget.product.images;
    }
    return [widget.product.thumbnail];
  }

  void _incrementQuantity() {
    if (_quantity < widget.product.stock) {
      setState(() => _quantity++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Only ${widget.product.stock} items in stock'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    ref
        .read(cartProvider.notifier)
        .addToCart(widget.product, quantity: _quantity);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.greenAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Added $_quantity x "${widget.product.title}" to cart',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: const Color(0xFFFFD54F),
          onPressed: () {
            ref.read(navigationIndexProvider.notifier).state = 2;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
      ),
    );
  }

  void _buyNow() {
    ref
        .read(cartProvider.notifier)
        .addToCart(widget.product, quantity: _quantity);
    ref.read(navigationIndexProvider.notifier).state = 2;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final images = _images;
    final cartCount = ref.watch(cartTotalCountProvider);
    final originalPrice = product.price * 1.25;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _isFavorite ? Colors.redAccent : AppColors.icon,
            ),
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFavorite ? 'Saved to Wishlist' : 'Removed from Wishlist',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.icon,
                ),
                onPressed: () {
                  ref.read(navigationIndexProvider.notifier).state = 2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
              ),
              if (cartCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isWide
              ? _buildWideLayout(product, images, originalPrice)
              : _buildMobileLayout(product, images, originalPrice),
        ),
      ),
      bottomSheet: Container(
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
        child: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '₹${(product.price * _quantity).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppColors.black, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _addToCart,
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _buyNow,
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    Product product,
    List<String> images,
    double originalPrice,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarousel(images, 280),
          Padding(
            padding: const EdgeInsets.all(18),
            child: _buildDetailsContent(product, originalPrice),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildWideLayout(
    Product product,
    List<String> images,
    double originalPrice,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _buildCarousel(images, 420),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailsContent(product, originalPrice),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(List<String> images, double height) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          CarouselSlider(
            items: images.map((imgUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imgUrl,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stack) {
                      return Container(
                        color: Colors.grey.shade100,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enableInfiniteScroll: images.length > 1,
              onPageChanged: (index, reason) {
                setState(() => _currentImageIndex = index);
              },
            ),
          ),
          if (images.length > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                final isSelected = _currentImageIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isSelected ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.black : Colors.black26,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsContent(Product product, double originalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '(80+ reviews)',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (product.brand.isNotEmpty)
          Text(
            product.brand.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
              letterSpacing: 1.1,
            ),
          ),

        const SizedBox(height: 6),

        Text(
          product.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '₹${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '₹${originalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textMuted,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Text(
                '20% OFF',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),
        const Text(
          'Inclusive of all taxes',
          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery in 15-25 minutes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Shipment from nearby local hub',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: _decrementQuantity,
                    color: _quantity > 1
                        ? AppColors.textPrimary
                        : AppColors.iconMuted,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: _incrementQuantity,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'About Product',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            _buildTrustBadge(
              Icons.verified_user_outlined,
              '100% Genuine',
            ),
            const SizedBox(width: 10),
            _buildTrustBadge(
              Icons.published_with_changes_outlined,
              '7 Days Return',
            ),
            const SizedBox(width: 10),
            _buildTrustBadge(
              Icons.payments_outlined,
              'COD Available',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustBadge(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: AppColors.icon),
            const SizedBox(height: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
