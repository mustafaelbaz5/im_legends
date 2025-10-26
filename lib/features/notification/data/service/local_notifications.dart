import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/router/app_router.dart' as AppRouter;
import '../../../../core/storage/secure_storage.dart';

class LocalNotificationService {
  // Singleton
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize local notifications
  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _handleNotificationTap(payload);
        }
      },
    );

    // Ask for POST_NOTIFICATIONS permission on Android 13+
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }

    // Ask for permission on iOS
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Show a local notification AND save it for the specific user
  Future<void> showNotification({
    required int id,
    required String? title,
    required String? body,
    required String userId,
    String? payload,
  }) async {
    final currentUserId = await SecureStorage().getUserId();

    // 🚨 Only show if this notification belongs to the logged-in user
    if (currentUserId != userId) {
      debugPrint("⏩ Skipping notification for another user: $userId");
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      channelDescription: 'Used for general app notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(id, title, body, details, payload: payload);
  }

  /// Handle notification tap → navigate
  void _handleNotificationTap(String payload) {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    AppRouter.navigatorKey.currentState?.pushNamed(payload);
  }
}
