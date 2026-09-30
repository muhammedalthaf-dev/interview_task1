import 'package:ecommerce_app/feature/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

final categoryGradientProvider = Provider<List<Color>>((ref) {
  final category = ref.watch(selectedCategoryProvider);

  switch (category) {
    case 'beauty':
      return AppColors.beautyGradient;

    case 'fragrances':
      return AppColors.fragrancesGradient;

    case 'furniture':
      return AppColors.furnitureGradient;

    case 'groceries':
      return AppColors.groceriesGradient;

    case 'laptops':
      return AppColors.laptopsGradient;

    case 'mens-shirts':
      return AppColors.mensShirtsGradient;

    case 'womens-bags':
      return AppColors.womensBagsGradient;

    case 'sports-accessories':
      return AppColors.sportsGradient;

    case 'all':
    default:
      return AppColors.allGradient;
  }
});
