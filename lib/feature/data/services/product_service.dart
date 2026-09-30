import 'package:dio/dio.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<dynamic>> getProducts(String category) async {
    final String url;

    if (category == 'all') {
      url = '/products?limit=0';
    } else {
      url = '/products/category/$category?limit=0';
    }

    final response = await dio.get(url);

    return response.data['products'];
  }

  Future<List<dynamic>> searchProducts(String query) async {
    final trimmed = query.trim();
    final String url;

    if (trimmed.isEmpty) {
      url = '/products?limit=0';
    } else {
      url = '/products/search?q=${Uri.encodeComponent(trimmed)}&limit=0';
    }

    final response = await dio.get(url);

    return response.data['products'];
  }
}
