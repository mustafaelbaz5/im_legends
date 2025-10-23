import '../../../../core/router/route_paths.dart';
import '../../../../core/service/supa_base_service.dart';
import '../../../../core/utils/notification_messages.dart';
import '../models/notification_model.dart';
import '../service/firebase_notifications_service.dart';
import '../service/local_notifications.dart';

class NotificationRepo {
  final SupaBaseService _supabaseService = SupaBaseService();
  final FirebaseNotificationsService _firebaseService =
      FirebaseNotificationsService();
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  /// Initialize notifications for a user
  Future<void> initialize(String userId) async {
    await _firebaseService.initialize(userId);
  }

  /// Send sign-up notification
  Future<void> sendSignUpNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    final notification = NotificationMessages.signUpMessage(
      userId: userId,
      userName: userName,
      email: email,
    );
    await _supabaseService.insertNotificationFromModel(notification);

    // Show local notification
    await _localNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: notification.title,
      body: notification.message,
      userId: userId,
      payload: Routes.notificationsScreen,
    );
  }

  /// Send login notification
  Future<void> sendLoginNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    final notification = NotificationMessages.loginMessage(
      userId: userId,
      userName: userName,
      email: email,
    );
    await _supabaseService.insertNotificationFromModel(notification);

    // Show local notification
    await _localNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: notification.title,
      body: notification.message,
      userId: userId,
      payload: Routes.notificationsScreen,
    );
  }

  Future<void> sendNotification(NotificationModel notification) async {
    await _supabaseService.insertNotificationFromModel(notification);

    await _localNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: notification.title,
      body: notification.message,
      userId: notification.userId,
      payload: Routes.notificationsScreen,
    );
  }

  /// Get user notifications
  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    if (userId.isEmpty) return [];
    return await _supabaseService.getUserNotifications(userId);
  }

  /// Get unread notifications count
  Future<int> getUnreadCount(String userId) async {
    final notifications = await getUserNotifications(userId);
    return notifications.where((n) => !n.isRead).length;
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    await _supabaseService.markAsRead(notificationId);
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead(String userId) async {
    final notifications = await getUserNotifications(userId);
    for (final notification in notifications.where((n) => !n.isRead)) {
      await markAsRead(notification.id);
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    await _supabaseService.deleteNotification(notificationId);
  }
}
