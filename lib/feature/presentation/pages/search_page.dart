import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../controllers/search_controller.dart';
import '../widgets/product_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _textController;
  Timer? _debounceTimer;

  static const List<String> _quickTags = [
    'All',
    'Beauty',
    'Fragrances',
    'Furniture',
    'Groceries',
    'Laptops',
    'Shirts',
    'Shoes',
    'Phone',
    'Watch',
    'Bags',
  ];

  @override
  void initState() {
    super.initState();
    final initialQuery = ref.read(searchQueryProvider);
    _textController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      ref.read(searchProductControllerProvider.notifier).search(query);
    });
    setState(() {});
  }

  void _clearSearch() {
    _textController.clear();
    _debounceTimer?.cancel();
    ref.read(searchProductControllerProvider.notifier).clear();
    setState(() {});
  }

  void _selectTag(String tag) {
    final query = tag == 'All' ? '' : tag;
    _textController.text = query;
    _debounceTimer?.cancel();
    ref.read(searchProductControllerProvider.notifier).search(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProductControllerProvider);
    final currentQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 14,
        toolbarHeight: 76,
        title: AppTextField(
          controller: _textController,
          hintText: 'Search products, brands, categories...',
          prefixIcon: Icons.search_rounded,
          textInputAction: TextInputAction.search,
          onChanged: _onSearchChanged,
          onSubmitted: (value) {
            _debounceTimer?.cancel();
            ref.read(searchProductControllerProvider.notifier).search(value);
          },
          suffixIcon: _textController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: AppColors.iconMuted,
                    size: 20,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick filter chips
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.only(bottom: 12, top: 4),
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: _quickTags.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tag = _quickTags[index];
                  final isSelected = tag == 'All'
                      ? currentQuery.isEmpty
                      : currentQuery.toLowerCase() == tag.toLowerCase();

                  return GestureDetector(
                    onTap: () => _selectTag(tag),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.surfaceSecondary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.black
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1, color: AppColors.divider),

          Expanded(
            child: searchState.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 54,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Failed to load products',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.invalidate(searchProductControllerProvider);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),

              data: (products) {
                if (products.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_off_rounded,
                              size: 56,
                              color: AppColors.iconMuted,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentQuery.isEmpty
                                ? 'No products available'
                                : 'No products found for "$currentQuery"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Try checking for typos or searching for a different keyword.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (currentQuery.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            OutlinedButton(
                              onPressed: _clearSearch,
                              child: const Text('Clear Search'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
                      child: Row(
                        children: [
                          Text(
                            currentQuery.isEmpty
                                ? 'All Products'
                                : 'Results for "$currentQuery"',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${products.length} items',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.68,
                            ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
