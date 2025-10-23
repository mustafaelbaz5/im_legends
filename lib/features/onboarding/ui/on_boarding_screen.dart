import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/logo_top_bar.dart';
import 'widgets/on_boarding_grid_cards.dart';
import 'widgets/on_boarding_icons.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                const LogoTopBar(),
                verticalSpacing(40),
                // Hero section
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main headline
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Color(0xFFE8E8E8)],
                      ).createShader(bounds),
                      child: Text(
                        'Dominate the Pitch\nWith Your Squad!',
                        style: BebasTextStyles.whiteBold24,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    verticalSpacing(16),

                    // Subtitle
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Challenge your friends, track your stats, and become the ultimate football legend in your crew',
                        style: RobotoTextStyles.greyRegular14.copyWith(
                          fontSize: 16,
                          color: const Color(0xFFB0B8C1),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalSpacing(20),
                    const OnBoardingGridCards(),
                    verticalSpacing(20),

                    // Stats preview row
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2832),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2A3441),
                          width: 1,
                        ),
                      ),
                      child: const OnBoardingIcons(),
                    ),
                    verticalSpacing(40),
                    CustomTextButton(
                      buttonText: 'Start Your Journey',
                      textStyle: RobotoTextStyles.whiteBold20,
                      onPressed: () => context.push(Routes.loginScreen),
                    ),
                    verticalSpacing(16),
                    Text(
                      'Join thousands of players already competing',
                      style: RobotoTextStyles.greyRegular12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
