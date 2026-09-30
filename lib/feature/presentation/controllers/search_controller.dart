import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';
import '../providers/product_di_provider.dart';

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) => state = query;
  void clear() => state = '';
}

final searchProductControllerProvider =
    AsyncNotifierProvider<SearchProductController, List<Product>>(
  SearchProductController.new,
);

class SearchProductController extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final query = ref.watch(searchQueryProvider);
    final searchProducts = ref.watch(searchProductsUseCaseProvider);

    return searchProducts(query);
  }

  void search(String query) {
    ref.read(searchQueryProvider.notifier).updateQuery(query);
  }

  void clear() {
    ref.read(searchQueryProvider.notifier).clear();
  }
}
