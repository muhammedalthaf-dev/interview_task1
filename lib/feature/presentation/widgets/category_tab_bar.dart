import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/category_provider.dart';

class CategoryTabBar extends ConsumerWidget {
  const CategoryTabBar({super.key});

  static const List<CategoryItem> categories = [
    CategoryItem(name: 'All', value: 'all', icon: Icons.shopping_bag_outlined),
    CategoryItem(name: 'Beauty', value: 'beauty', icon: Icons.spa_outlined),
    CategoryItem(
      name: 'Fragrances',
      value: 'fragrances',
      icon: Icons.local_florist_outlined,
    ),
    CategoryItem(
      name: 'Furniture',
      value: 'furniture',
      icon: Icons.weekend_outlined,
    ),
    CategoryItem(
      name: 'Groceries',
      value: 'groceries',
      icon: Icons.shopping_cart_outlined,
    ),
    CategoryItem(
      name: 'Laptops',
      value: 'laptops',
      icon: Icons.laptop_outlined,
    ),
    CategoryItem(
      name: 'Mens Shirts',
      value: 'mens-shirts',
      icon: Icons.checkroom_outlined,
    ),
    CategoryItem(
      name: 'Womens Bags',
      value: 'womens-bags',
      icon: Icons.shopping_bag_outlined,
    ),
    CategoryItem(
      name: 'Sports',
      value: 'sports-accessories',
      icon: Icons.sports_soccer_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 82,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          final isSelected = selectedCategory == category.value;

          return GestureDetector(
            onTap: () {
              ref.read(selectedCategoryProvider.notifier).state =
                  category.value;
            },
            child: SizedBox(
              width: 82,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.35)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(category.icon, size: 27, color: Colors.black),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: isSelected ? 42 : 0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final String value;
  final IconData icon;

  const CategoryItem({
    required this.name,
    required this.value,
    required this.icon,
  });
}
