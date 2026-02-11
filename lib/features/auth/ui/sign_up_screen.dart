import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../../../core/router/routes.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/sign_up_bloc_consumer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpacing(40),
                Text(
                  'auth.sign_up_title'.tr(),
                  style: AppTextStyles.font20Bold,
                ),
                verticalSpacing(32),
                const SignUpBlocConsumer(),
                verticalSpacing(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'auth.already_have_account'.tr(),
                      style: AppTextStyles.font12Regular,
                    ),
                    GestureDetector(
                      onTap: () => context.pushReplacementNamed(Routes.loginScreen),
                      child: Text(
                        'auth.login'.tr(),
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: context.customColors.accentBlue,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpacing(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
