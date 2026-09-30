import 'package:ecommerce_app/feature/domain/entities/product.dart';
import 'package:ecommerce_app/feature/presentation/providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final productProvider = StateProvider<List<Product>>((ref) {
  return [];
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == 'all') {
    return products;
  }

  return products
      .where((product) => product.category == selectedCategory)
      .toList();
});
