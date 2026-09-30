import 'package:ecommerce_app/core/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository_impl.dart';
import '../../data/services/product_service.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  final dio = ref.watch(dioProvider);

  return ProductService(dio);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final service = ref.watch(productServiceProvider);

  return ProductRepositoryImpl(service);
});

final getProductsProvider = Provider<GetProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);

  return GetProducts(repository);
});

final searchProductsUseCaseProvider = Provider<SearchProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);

  return SearchProducts(repository);
});
