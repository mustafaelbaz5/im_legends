import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_texts_style.dart';

class NotificationAppBar extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onBack;
  final VoidCallback onMarkAllAsRead;

  const NotificationAppBar({
    super.key,
    required this.unreadCount,
    required this.onBack,
    required this.onMarkAllAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 50.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.sp,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications', style: BebasTextStyles.whiteBold20),
                if (unreadCount > 0)
                  Text(
                    '$unreadCount new notifications',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          if (unreadCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.blue[700]!),
              ),
              child: GestureDetector(
                onTap: onMarkAllAsRead,
                child: Text(
                  'Mark all read',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue[200],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
