// custom_app_bar.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:im_legends/core/router/route_paths.dart';
import 'package:im_legends/features/notification/logic/cubit/notifications_cubit.dart';
import 'package:im_legends/features/profile/logic/cubit/profile_cubit.dart';

import '../themes/app_texts_style.dart';
import '../utils/app_assets.dart';
import '../utils/spacing.dart';
import 'notification_icon.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF191919),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF323743),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(title, style: BebasTextStyles.whiteBold20),
            ),
          ),
          // Notifications from cubit
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess) {
                final unreadCount = state.notifications
                    .where((notification) => !notification.isRead)
                    .length;
                return NotificationIcon(unreadCount: unreadCount);
              } else {
                return const NotificationIcon(unreadCount: 0);
              }
            },
          ),
          horizontalSpacing(8),
          GestureDetector(
            onTap: () => context.go(Routes.profileScreen),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileSuccess) {
                        final profile = state.player.user;
                        if (profile.profileImageUrl == null ||
                            profile.profileImageUrl!.isEmpty) {
                          return SvgPicture.asset(
                            AppAssets.appLogo,
                            fit: BoxFit.cover,
                            width: 36,
                            height: 36,
                          );
                        }
                        return CachedNetworkImage(
                          imageUrl: profile.profileImageUrl!,
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset(
                                AppAssets.appLogo,
                                fit: BoxFit.cover,
                                width: 36,
                                height: 36,
                              ),
                        );
                      } else {
                        return SvgPicture.asset(
                          AppAssets.appLogo,
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
