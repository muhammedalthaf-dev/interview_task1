import 'package:ecommerce_app/feature/domain/entities/product.dart';
import 'package:ecommerce_app/feature/presentation/pages/cart_page.dart';
import 'package:ecommerce_app/feature/presentation/pages/checkout_page.dart';
import 'package:ecommerce_app/feature/presentation/providers/cart_provider.dart';
import 'package:ecommerce_app/feature/presentation/widgets/cart_bill_summary.dart';
import 'package:ecommerce_app/feature/presentation/widgets/cart_item_tile.dart';
import 'package:ecommerce_app/feature/presentation/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const productA = Product(
    id: 1,
    title: 'Wireless Earbuds',
    description: 'High quality sound',
    price: 100.0,
    rating: 4.5,
    stock: 20,
    brand: 'AudioPro',
    category: 'electronics',
    thumbnail: 'https://example.com/earbuds.png',
    images: [],
  );

  const productB = Product(
    id: 2,
    title: 'Coffee Mug',
    description: 'Ceramic coffee mug',
    price: 50.0,
    rating: 4.8,
    stock: 10,
    brand: 'HomeGoods',
    category: 'home',
    thumbnail: 'https://example.com/mug.png',
    images: [],
  );

  group('CartNotifier tests', () {
    test('addToCart adds products and calculates subtotal & count correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);

      expect(container.read(cartTotalCountProvider), 0);
      expect(container.read(cartTotalPriceProvider), 0.0);

      // Add product A
      notifier.addToCart(productA, quantity: 2);
      expect(container.read(cartTotalCountProvider), 2);
      expect(container.read(cartTotalPriceProvider), 200.0);

      // Add product B
      notifier.addToCart(productB, quantity: 1);
      expect(container.read(cartTotalCountProvider), 3);
      expect(container.read(cartTotalPriceProvider), 250.0);

      // Delivery fee below 499 is 29.0
      expect(container.read(cartDeliveryFeeProvider), 29.0);
      // Grand total = 250 + 29 + 4 = 283
      expect(container.read(cartGrandTotalProvider), 283.0);
    });

    test('increment, decrement, and remove operations work properly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);

      notifier.addToCart(productA, quantity: 2);
      expect(container.read(cartTotalCountProvider), 2);

      // Increment
      notifier.incrementQuantity(1);
      expect(container.read(cartTotalCountProvider), 3);
      expect(container.read(cartTotalPriceProvider), 300.0);

      // Decrement
      notifier.decrementQuantity(1);
      expect(container.read(cartTotalCountProvider), 2);

      // Remove
      notifier.removeFromCart(1);
      expect(container.read(cartTotalCountProvider), 0);
      expect(container.read(cartProvider).isEmpty, true);
    });
  });

  group('CartPage Widget tests', () {
    testWidgets('shows EmptyCartWidget when cart is empty',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.byType(EmptyCartWidget), findsOneWidget);
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Start Shopping'), findsOneWidget);
    });

    testWidgets('shows items, bill summary and proceeds to checkout',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Add item to cart
      container.read(cartProvider.notifier).addToCart(productA, quantity: 2);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pump();

      // Verify Cart Header
      expect(find.text('My Cart (2)'), findsOneWidget);

      // Verify CartItemTile
      expect(find.byType(CartItemTile), findsOneWidget);
      expect(find.text('Wireless Earbuds'), findsOneWidget);

      // Verify CartBillSummary
      expect(find.byType(CartBillSummary), findsOneWidget);
      expect(find.text('Bill Details'), findsOneWidget);

      // Verify Proceed to Pay button
      expect(find.text('Proceed to Pay'), findsOneWidget);

      // Tap Proceed to Pay
      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      // Should open CheckoutPage
      expect(find.byType(CheckoutPage), findsOneWidget);
      expect(find.text('Place Order'), findsOneWidget);
    });
  });
}
