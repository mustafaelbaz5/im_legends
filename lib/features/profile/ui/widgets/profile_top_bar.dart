import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/app_assets.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: AppColors.primary300,
      height: responsiveHeight(220),
      child: Padding(
        padding: EdgeInsets.only(
          left: responsiveWidth(24),
          right: responsiveWidth(24),
          top: responsiveHeight(56),
          bottom: responsiveHeight(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: AppTextStyles.font20Bold.copyWith(color: AppColors.grey0),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.notificationsScreen),
              child: SvgPicture.asset(
                AppAssets.notificationIconSvg,
                colorFilter: const ColorFilter.mode(
                  AppColors.grey0,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
