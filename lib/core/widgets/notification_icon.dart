import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/app_assets.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

class NotificationIcon extends StatelessWidget {
  final int unreadCount;
  const NotificationIcon({super.key, required this.unreadCount});

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.notificationsScreen);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            AppAssets.notificationIconSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primary300,
              BlendMode.srcIn,
            ),
          ),
          if (unreadCount > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.customColors.errorContainer,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Center(
                  child: Text(
                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                    style: AppTextStyles.font12SemiBold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
