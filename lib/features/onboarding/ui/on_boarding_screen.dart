import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/router/routes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/extensions/context_extensions.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_text_button.dart';

import 'widgets/on_boarding_hero_image.dart';
import 'widgets/on_boarding_top_bar.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(20),
            vertical: responsiveHeight(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OnBoardingTopBar(),
              verticalSpacing(20),

              // Hero Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main Headline
                  Text(
                    'IM LEGENDS',
                    style: AppTextStyles.fontBold.copyWith(
                      fontSize: responsiveFontSize(32),
                      color: AppColors.primary300,
                    ),
                  ),
                  verticalSpacing(12),

                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(12),
                    ),
                    child: Text(
                      'onboarding.subtitle'.tr(),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: context.customColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpacing(20),

                  // Hero Image with overlay
                  const OnBoardingHeroImage(),

                  verticalSpacing(20),

                  // CTA Button
                  SizedBox(
                    width: responsiveWidth(300),
                    child: CustomTextButton(
                      text: 'onboarding.button'.tr(),
                      onPressed: () => context.pushNamed(Routes.loginScreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
