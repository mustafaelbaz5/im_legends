import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'widgets/sign_up_bloc_consumer.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/logo_top_bar.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/router/route_paths.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LogoTopBar(),
                  verticalSpacing(40.h),
                  Text(
                    'Welcome to IM Legends! 👋',
                    style: RobotoTextStyles.whiteBold20,
                    semanticsLabel: 'Sign Up to IM Legends',
                  ),
                  verticalSpacing(32),
                  const SignUpBlocConsumer(),
                  verticalSpacing(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: RobotoTextStyles.greyRegular16,
                      ),

                      TextButton(
                        onPressed: () => context.go(Routes.loginScreen),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          overlayColor: Colors.white12,
                        ),
                        child: Text(
                          "Log In",
                          style: RobotoTextStyles.greyRegular16.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
