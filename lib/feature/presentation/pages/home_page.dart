import 'package:ecommerce_app/feature/presentation/providers/category_provider.dart';
import 'package:ecommerce_app/feature/presentation/widgets/category_banner.dart';
import 'package:ecommerce_app/feature/presentation/widgets/category_tap.dart';
import 'package:ecommerce_app/feature/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/product_controller.dart';
import '../providers/navigation_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BlinkitAppBar(
        onSearchTap: () {
          ref.read(navigationIndexProvider.notifier).state = 1;
        },
      ),

      body: productState.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },

        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 50),

                const SizedBox(height: 12),

                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 6),

                Text(error.toString(), textAlign: TextAlign.center),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(productControllerProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },

        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: CategoryBanner(
                  key: ValueKey(ref.watch(selectedCategoryProvider)),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 10)),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];

                    return ProductCard(product: product);
                  }, childCount: products.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }
}
