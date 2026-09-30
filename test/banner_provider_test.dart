import 'package:ecommerce_app/feature/presentation/providers/banner_provider.dart';
import 'package:ecommerce_app/feature/presentation/providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('categoryBannersProvider tests', () {
    test('default category returns "all" category banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final banners = container.read(categoryBannersProvider);

      expect(banners.isNotEmpty, true);
      expect(banners.every((b) => b.startsWith('assets/banner/all/')), true);
      expect(banners.length, 5);
    });

    test('selecting "beauty" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'beauty';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 6);
      expect(banners.every((b) => b.startsWith('assets/banner/beauty/')), true);
    });

    test('selecting "fragrances" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'fragrances';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 5);
      expect(banners.every((b) => b.startsWith('assets/banner/fragrances/')), true);
    });

    test('selecting "furniture" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'furniture';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 5);
      expect(banners.every((b) => b.startsWith('assets/banner/furniture/')), true);
    });

    test('selecting "groceries" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'groceries';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 5);
      expect(banners.every((b) => b.startsWith('assets/banner/groceries/')), true);
    });

    test('selecting "laptops" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'laptops';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 4);
      expect(banners.every((b) => b.startsWith('assets/banner/laptops/')), true);
    });

    test('selecting "mens-shirts" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'mens-shirts';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 4);
      expect(banners.every((b) => b.startsWith('assets/banner/menshirt/')), true);
    });

    test('selecting "womens-bags" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'womens-bags';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 5);
      expect(banners.every((b) => b.startsWith('assets/banner/women/')), true);
    });

    test('selecting "sports-accessories" category updates banners', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'sports-accessories';

      final banners = container.read(categoryBannersProvider);

      expect(banners.length, 3);
      expect(banners.every((b) => b.startsWith('assets/banner/sports/')), true);
    });
  });
}
