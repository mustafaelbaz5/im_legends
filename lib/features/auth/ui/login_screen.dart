import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/router/route_paths.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/login_bloc_consumer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(16),
            vertical: responsiveHeight(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpacing(40),
                Text(
                  'auth.login_title'.tr(),
                  style: AppTextStyles.font20Bold,
                  textAlign: TextAlign.center,
                ),
                verticalSpacing(12),
                Text(
                  'auth.login_desc'.tr(),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customColors.textSecondary,
                    height: 1.8,
                  ),
                ),
                verticalSpacing(80),

                const LoginBlocConsumer(),
                verticalSpacing(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'auth.dont_have_account'.tr(),
                      style: AppTextStyles.font12Regular,
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.pushReplacementNamed(Routes.signUpScreen),
                      child: Text(
                        'auth.sign_up'.tr(),
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: context.customColors.accentBlue,
                          decorationThickness: 2,
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
    );
  }
}
