import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/banner_provider.dart';

class CategoryBanner extends ConsumerStatefulWidget {
  const CategoryBanner({super.key});

  @override
  ConsumerState<CategoryBanner> createState() => _CategoryBannerState();
}

class _CategoryBannerState extends ConsumerState<CategoryBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(categoryBannersProvider);

    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    final hasMultiple = banners.length > 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            final image = banners[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 36,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: hasMultiple,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeInOut,
            enableInfiniteScroll: hasMultiple,
            enlargeCenterPage: true,
            enlargeFactor: 0.16,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.93,
            onPageChanged: (index, reason) {
              if (mounted) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
          ),
        ),

        if (hasMultiple) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isSelected ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.black87
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
