import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';
import '../providers/category_provider.dart';
import '../providers/product_di_provider.dart';

final productControllerProvider =
    AsyncNotifierProvider<ProductController, List<Product>>(
      ProductController.new,
    );

class ProductController extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final category = ref.watch(selectedCategoryProvider);

    final getProducts = ref.read(getProductsProvider);

    return getProducts(category);
  }
}
