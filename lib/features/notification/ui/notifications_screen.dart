import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/themes/app_colors.dart';
import '../logic/cubit/notifications_cubit.dart';
import 'widgets/notification_app_bar.dart';
import 'widgets/notification_card.dart';
import 'widgets/notification_empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              int unreadCount = 0;
              if (state is NotificationsSuccess) {
                unreadCount = state.notifications
                    .where((notification) => !notification.isRead)
                    .length;
              }
              return NotificationAppBar(
                unreadCount: unreadCount,
                onBack: () => Navigator.of(context).pop(),
                onMarkAllAsRead: () =>
                    context.read<NotificationsCubit>().markAllAsRead(),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is NotificationsFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Error loading notifications',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<NotificationsCubit>()
                                .fetchNotifications();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is NotificationsSuccess) {
                  final notifications = state.notifications;
                  // Add these debug prints
                  print('🔍 Total notifications: ${notifications.length}');
                  print(
                    '🔍 Unique notification IDs: ${notifications.map((n) => n.id).toSet().length}',
                  );

                  // Check for duplicates
                  final ids = notifications.map((n) => n.id).toList();
                  final uniqueIds = ids.toSet();
                  if (ids.length != uniqueIds.length) {
                    print('❌ DUPLICATES FOUND!');
                    print('All IDs: $ids');
                    print('Unique IDs: $uniqueIds');
                  }

                  if (notifications.isEmpty) {
                    return const NotificationEmptyState();
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NotificationsCubit>().fetchNotifications();
                    },
                    backgroundColor: AppColors.lightDarkColor,
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return NotificationCard(
                          notification: notification,
                          index: index,
                          onDelete: () {
                            context
                                .read<NotificationsCubit>()
                                .deleteNotification(notification.id);

                            // Show snackbar with undo option
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Notification deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {},
                                ),
                                duration: const Duration(seconds: 3),
                                backgroundColor: Colors.grey[800],
                              ),
                            );
                          },
                       
                          onTap: () {
                            // Mark as read first
                            context.read<NotificationsCubit>().markAsRead(
                              notification.id,
                            );

                            // Then navigate to details
                            context.push(
                              Routes.notificationDetailsScreen,
                              extra: notification,
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const NotificationEmptyState();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
