import 'package:ecommerce_app/feature/domain/entities/product.dart';
import 'package:ecommerce_app/feature/presentation/controllers/search_controller.dart';
import 'package:ecommerce_app/feature/presentation/pages/search_page.dart';
import 'package:ecommerce_app/feature/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testProducts = [
    const Product(
      id: 1,
      title: 'iPhone 15 Pro',
      description: 'Apple flagship smartphone',
      price: 999.0,
      rating: 4.8,
      stock: 50,
      brand: 'Apple',
      category: 'smartphones',
      thumbnail: 'https://cdn.dummyjson.com/products/images/smartphones/iPhone%2015%20Pro/thumbnail.png',
      images: [],
    ),
    const Product(
      id: 2,
      title: 'MacBook Air M2',
      description: 'Ultra thin laptop',
      price: 1199.0,
      rating: 4.9,
      stock: 30,
      brand: 'Apple',
      category: 'laptops',
      thumbnail: 'https://cdn.dummyjson.com/products/images/laptops/MacBook%20Air%20M2/thumbnail.png',
      images: [],
    ),
  ];

  testWidgets('SearchPage renders search bar, chips and product grid',
      (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        searchProductControllerProvider.overrideWith(
          () => MockSearchProductController(testProducts),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: SearchPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify search input field is present
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is TextField &&
            w.decoration?.hintText == 'Search products, brands, categories...',
      ),
      findsOneWidget,
    );

    // Verify filter chips exist
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Beauty'), findsOneWidget);
    expect(find.text('Laptops'), findsOneWidget);

    // Verify results header
    expect(find.text('All Products'), findsOneWidget);
    expect(find.text('2 items'), findsOneWidget);

    // Verify GridView and ProductCard count
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(ProductCard), findsNWidgets(2));
    expect(find.text('iPhone 15 Pro'), findsOneWidget);
    expect(find.text('MacBook Air M2'), findsOneWidget);
  });

  testWidgets('SearchPage shows empty state when no products match',
      (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        searchProductControllerProvider.overrideWith(
          () => MockSearchProductController([]),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: SearchPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No products available'), findsOneWidget);
    expect(find.byType(ProductCard), findsNothing);
  });
}

class MockSearchProductController extends SearchProductController {
  final List<Product> mockProducts;

  MockSearchProductController(this.mockProducts);

  @override
  Future<List<Product>> build() async {
    return mockProducts;
  }
}
