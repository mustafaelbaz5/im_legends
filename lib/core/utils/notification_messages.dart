import 'package:intl/intl.dart';

import '../../features/notification/data/models/notification_model.dart';

class NotificationMessages {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  static NotificationModel loginMessage({
    required String userId,
    required String userName,
    required String email,
  }) {
    final now = DateTime.now();
    return NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      userId: userId,
      title: "Welcome Back! 👋",
      message:
          "Hi $userName, you logged in successfully on ${_dateFormat.format(now)}.\nEmail: $email",
      time: now,
      type: NotificationType.system,
      isRead: false,
    );
  }

  static NotificationModel signUpMessage({
    required String userId,
    required String userName,
    required String email,
  }) {
    final now = DateTime.now();
    return NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      userId: userId,
      title: "Welcome to IM Legends! 🎉",
      message:
          "Hi $userName, your account was created on ${_dateFormat.format(now)}.\nEmail: $email",
      time: now,
      type: NotificationType.system,
      isRead: false,
    );
  }

  static NotificationModel winnerMessage({
    required String userId,
    required String userName,
  }) {
    final now = DateTime.now();
    return NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      userId: userId,
      title: "Congratulations! 🎉",
      message: "Hi $userName, you won the game on ${_dateFormat.format(now)}",
      time: now,
      type: NotificationType.welcome,
      isRead: false,
    );
  }

  static NotificationModel loserMessage({
    required String userId,
    required String userName,
  }) {
    final now = DateTime.now();
    return NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      userId: userId,
      title: "Unlucky, $userName 😔",
      message: "Hi $userName, you lost the game on ${_dateFormat.format(now)}",
      time: now,
      type: NotificationType.welcome,
      isRead: false,
    );
  }
}
