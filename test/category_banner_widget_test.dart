import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/feature/presentation/providers/category_provider.dart';
import 'package:ecommerce_app/feature/presentation/widgets/category_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CategoryBanner renders and updates when category changes',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CategoryBanner(),
          ),
        ),
      ),
    );

    // Initial render should have CarouselSlider
    expect(find.byType(CarouselSlider), findsOneWidget);

    // Initial category is 'all' (5 banners) -> 5 indicator dots
    expect(find.byType(AnimatedContainer), findsNWidgets(5));

    // Change category to 'beauty' (6 banners)
    container.read(selectedCategoryProvider.notifier).state = 'beauty';
    await tester.pumpAndSettle();

    // Now there should be 6 indicator dots
    expect(find.byType(AnimatedContainer), findsNWidgets(6));

    // Change category to 'sports-accessories' (3 banners)
    container.read(selectedCategoryProvider.notifier).state = 'sports-accessories';
    await tester.pumpAndSettle();

    // Now there should be 3 indicator dots
    expect(find.byType(AnimatedContainer), findsNWidgets(3));
  });
}
