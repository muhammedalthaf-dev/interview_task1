import 'package:ecommerce_app/feature/domain/entities/product.dart';
import 'package:ecommerce_app/feature/presentation/pages/product_details_page.dart';
import 'package:ecommerce_app/feature/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testProduct = Product(
    id: 99,
    title: 'Sony WH-1000XM5',
    description: 'Industry-leading noise canceling wireless headphones',
    price: 349.0,
    rating: 4.7,
    stock: 15,
    brand: 'Sony',
    category: 'headphones',
    thumbnail: 'https://cdn.dummyjson.com/products/images/headphones.png',
    images: [
      'https://cdn.dummyjson.com/products/images/headphones-1.png',
      'https://cdn.dummyjson.com/products/images/headphones-2.png',
    ],
  );

  testWidgets('ProductDetailsPage renders product info, prices and actions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ProductDetailsPage(product: testProduct),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Sony WH-1000XM5'), findsOneWidget);
    expect(find.text('SONY'), findsOneWidget);
    expect(find.text('HEADPHONES'), findsOneWidget);

    expect(find.text('₹349'), findsAtLeast(1));

    expect(
      find.text('Industry-leading noise canceling wireless headphones'),
      findsOneWidget,
    );

    expect(find.text('100% Genuine'), findsOneWidget);
    expect(find.text('7 Days Return'), findsOneWidget);
    expect(find.text('COD Available'), findsOneWidget);

    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.text('Buy Now'), findsOneWidget);

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
    expect(find.text('₹698'), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pump();

    final cartItems = container.read(cartProvider);
    expect(cartItems.length, 1);
    expect(cartItems.first.product.id, 99);
    expect(cartItems.first.quantity, 2);
  });
}
