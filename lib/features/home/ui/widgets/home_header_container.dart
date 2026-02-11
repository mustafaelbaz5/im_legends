import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/app_assets.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';

class HomeHeaderContainer extends StatefulWidget {
  const HomeHeaderContainer({super.key});

  @override
  State<HomeHeaderContainer> createState() => _HomeHeaderContainerState();
}

class _HomeHeaderContainerState extends State<HomeHeaderContainer> {
  int activeIndex = 0;

  final List<String> images = [
    AppAssets.championBannerjpg,
    AppAssets.championBannerjpg,
    AppAssets.championBannerjpg,
  ];

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsiveRadius(24)),
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              options: CarouselOptions(
                height: responsiveHeight(220),
                viewportFraction: 0.85,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (final context, final index, final realIndex) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: responsiveHeight(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(responsiveRadius(24)),

                    image: const DecorationImage(
                      image: AssetImage(AppAssets.championBannerjpg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(responsiveRadius(24)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          context.customColors.textPrimary.withValues(
                            alpha: 0.5,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(28),
                      vertical: responsiveHeight(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          "Challenge Mode ${index + 1}",
                          style: AppTextStyles.font18Bold,
                        ),
                        verticalSpacing(6),
                        Text(
                          "Compete and dominate the leaderboard",
                          style: AppTextStyles.font12Regular,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
