import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService service;

  ProductRepositoryImpl(this.service);

  @override
  Future<List<Product>> getProducts(String category) async {
    final data = await service.getProducts(category);

    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final data = await service.searchProducts(query);

    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
