import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category_provider.dart';

final categoryBannersProvider = Provider<List<String>>((ref) {
  final category = ref.watch(selectedCategoryProvider);

  switch (category) {
    case 'beauty':
      return const [
        'assets/banner/beauty/banner1.jpg',
        'assets/banner/beauty/banner2.jpg',
        'assets/banner/beauty/banner3.jpg',
        'assets/banner/beauty/banner4.jpg',
        'assets/banner/beauty/banner5.jpg',
        'assets/banner/beauty/banner6.jpg',
      ];

    case 'fragrances':
      return const [
        'assets/banner/fragrances/banner1.jpg',
        'assets/banner/fragrances/banner2.jpg',
        'assets/banner/fragrances/banner3.jpg',
        'assets/banner/fragrances/banner4.jpg',
        'assets/banner/fragrances/banner5.jpg',
      ];

    case 'furniture':
      return const [
        'assets/banner/furniture/banner1.jpg',
        'assets/banner/furniture/banner2.jpg',
        'assets/banner/furniture/banner3.jpg',
        'assets/banner/furniture/banner4.jpg',
        'assets/banner/furniture/banner5.jpg',
      ];

    case 'groceries':
      return const [
        'assets/banner/groceries/banner1.jpg',
        'assets/banner/groceries/banner2.jpg',
        'assets/banner/groceries/banner3.jpg',
        'assets/banner/groceries/banner4.jpg',
        'assets/banner/groceries/banner5.jpg',
      ];

    case 'laptops':
      return const [
        'assets/banner/laptops/banner1.jpg',
        'assets/banner/laptops/banner2.jpg',
        'assets/banner/laptops/banner3.jpg',
        'assets/banner/laptops/banner4.jpg',
      ];

    case 'mens-shirts':
      return const [
        'assets/banner/menshirt/banner1.jpg',
        'assets/banner/menshirt/banner2.jpg',
        'assets/banner/menshirt/banner3.jpg',
        'assets/banner/menshirt/banner4.jpg',
      ];

    case 'womens-bags':
      return const [
        'assets/banner/women/banner1.jpg',
        'assets/banner/women/banner2.jpg',
        'assets/banner/women/banner3.jpg',
        'assets/banner/women/banner4.jpg',
        'assets/banner/women/banner5.jpg',
      ];

    case 'sports-accessories':
      return const [
        'assets/banner/sports/banner1.jpg',
        'assets/banner/sports/banner2.jpg',
        'assets/banner/sports/banner3.jpg',
      ];

    case 'all':
    default:
      return const [
        'assets/banner/all/banner1.jpg',
        'assets/banner/all/banner2.jpg',
        'assets/banner/all/banner3.jpg',
        'assets/banner/all/banner4.jpg',
        'assets/banner/all/banner5.jpg',
      ];
  }
});
