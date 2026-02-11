import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/utils/app_assets.dart';
import 'package:im_legends/core/utils/spacing.dart';

class OnBoardingHeroImage extends StatelessWidget {
  const OnBoardingHeroImage({super.key});

  @override
  Widget build(final BuildContext context) {
    // Give a fixed height based on screen
    final double imageHeight = responsiveHeight(430);

    return Stack(
      children: [
        // SVG with fixed height
        SizedBox(
          width: double.infinity,
          height: imageHeight,
          child: SvgPicture.asset(
            AppAssets.onBoardingHereSvg,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
