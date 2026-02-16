import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/core/widgets/notification_icon.dart';

import '../../../../core/utils/extensions/context_extensions.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(24),
        vertical: responsiveHeight(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                "${'home.welcome_message'.tr()} $title",
                style: AppTextStyles.font18Bold,
              ),
              Text(
                'home.welcome_description'.tr(),
                style: AppTextStyles.font12Regular,
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: responsiveRadius(20),
            backgroundColor: context.customColors.divider.withValues(
              alpha: 0.5,
            ),
            child: const NotificationIcon(unreadCount: 3),
          ),
        ],
      ),
    );
  }
}
