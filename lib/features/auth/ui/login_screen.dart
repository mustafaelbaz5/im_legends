import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/logo_top_bar.dart';
import 'widgets/login_bloc_consumer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoTopBar(),
                  verticalSpacing(40.h),
                  Text(
                    'Welcome Back! 👋',
                    style: BebasTextStyles.whiteBold24,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(32),
                  const LoginBlocConsumer(),
                  verticalSpacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: RobotoTextStyles.greyRegular16,
                      ),

                      TextButton(
                        onPressed: () => context.go(Routes.signUpScreen),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          overlayColor: Colors.white12,
                        ),
                        child: Text(
                          "Sign Up",
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
