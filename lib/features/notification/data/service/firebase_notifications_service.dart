import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/service/supa_base_service.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/notification_model.dart';

class FirebaseNotificationsService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final SupaBaseService _supabaseService = SupaBaseService();

  /// Initialize Firebase service for a user
  Future<void> initialize(String userId) async {
    // Request notification permissions
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // Save or update FCM token
    final token = await _messaging.getToken();
    if (token != null) {
      await _supabaseService.saveOrUpdateToken(userId, token);
      await SecureStorage().saveToken(token);
    }

    // Handle token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      await _supabaseService.saveOrUpdateToken(userId, newToken);
    });

    // Setup message handlers
    FirebaseMessaging.onMessage.listen(
      (message) => _handleForegroundMessage(message, userId),
    );
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(
    RemoteMessage message,
    String userId,
  ) async {
    final notification = message.notification;
    if (notification == null) return;

    await saveNotification(message, userId);
  }

  /// Handle navigation when notification is tapped
  void _handleMessageNavigation(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final route = message.data['route'] ?? Routes.notificationsScreen;
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute != route) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route,
        (route) => false,
        arguments: message,
      );
    }
  }

  /// Save notification to Supabase
  Future<NotificationModel> saveNotification(
    RemoteMessage message,
    String userId,
  ) async {
    final notification = message.notification;
    if (notification == null) {
      throw Exception('No notification data');
    }

    final messageId =
        message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString();
    final type = _getNotificationType(message.data);

    final notificationModel = NotificationModel(
      id: messageId,
      userId: userId,
      title: notification.title ?? 'New Notification',
      message: notification.body ?? '',
      type: type,
      isRead: false,
      time: DateTime.now(),
    );

    await _supabaseService.insertNotification(
      userId: userId,
      title: notification.title ?? 'New Notification',
      message: notification.body ?? '',
      type: type,
      notificationId: messageId,
    );

    return notificationModel;
  }

  /// Determine notification type from message data
  NotificationType _getNotificationType(Map<String, dynamic> data) {
    final typeString = data['type'] as String?;
    return typeString != null
        ? NotificationType.values.firstWhere(
            (type) => type.name == typeString,
            orElse: () => NotificationType.system,
          )
        : NotificationType.system;
  }

  /// Handle background notifications
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    final userId = await SecureStorage().getUserId();
    if (userId == null) return;

    await saveNotification(message, userId);
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final userId = await SecureStorage().getUserId();
  if (userId == null) return;

  final supabaseService = SupaBaseService();
  final notification = message.notification;
  if (notification == null) return;

  final messageId =
      message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString();
  final typeString = message.data['type'] as String?;
  final type = typeString != null
      ? NotificationType.values.firstWhere(
          (type) => type.name == typeString,
          orElse: () => NotificationType.system,
        )
      : NotificationType.system;

  await supabaseService.insertNotification(
    userId: userId,
    title: notification.title ?? 'New Notification',
    message: notification.body ?? '',
    type: type,
    notificationId: messageId,
  );
}
