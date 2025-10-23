import 'package:bloc/bloc.dart';
import '../../../../core/service/supa_base_service.dart';
import '../../../../core/utils/notification_messages.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../data/repos/notification_repo.dart';
import '../../data/models/notification_model.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.notificationRepo})
    : super(NotificationsInitial());

  final NotificationRepo notificationRepo;
  final SecureStorage secureStorage = SecureStorage();
  final SupaBaseService supabaseService = SupaBaseService();

  /// Fetch notifications for the current user
  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(NotificationsFailure(errorMessage: 'User ID not found'));
        return;
      }

      final notifications = await notificationRepo.getUserNotifications(userId);
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Send login notification
  Future<void> sendLoginNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    try {
      await notificationRepo.sendLoginNotification(
        userId: userId,
        userName: userName,
        email: email,
      );
      await fetchNotifications(); // Refresh notifications
    } catch (e) {
      emit(
        NotificationsFailure(
          errorMessage: 'Failed to send login notification: $e',
        ),
      );
    }
  }

  /// Send sign-up notification
  Future<void> sendSignUpNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    try {
      await notificationRepo.sendSignUpNotification(
        userId: userId,
        userName: userName,
        email: email,
      );
      await fetchNotifications(); // Refresh notifications
    } catch (e) {
      emit(
        NotificationsFailure(
          errorMessage: 'Failed to send sign-up notification: $e',
        ),
      );
    }
  }

  Future<void> handleMatchResult({
    required String winnerId,
    required String loserId,
  }) async {
    try {
      print("⚡ WinnerId: $winnerId | LoserId: $loserId");

      final winnerData = await supabaseService.fetchUserProfileById(winnerId);
      final loserData = await supabaseService.fetchUserProfileById(loserId);

      final winnerName = winnerData?['name'] ?? 'Player';
      final loserName = loserData?['name'] ?? 'Player';

      print("🏆 WinnerName: $winnerName | ❌ LoserName: $loserName");

      // ✅ Create notifications
      final winnerNotification = NotificationMessages.winnerMessage(
        userId: winnerId,
        userName: winnerName,
      );

      final loserNotification = NotificationMessages.loserMessage(
        userId: loserId,
        userName: loserName,
      );

      // ✅ Send both
      await notificationRepo.sendNotification(winnerNotification);
      await notificationRepo.sendNotification(loserNotification);

      await fetchNotifications();
    } catch (e) {
      emit(
        NotificationsFailure(errorMessage: 'Failed to send match results: $e'),
      );
    }
  }

  /// Mark a single notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationRepo.markAsRead(notificationId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Mark all notifications as read for the current user
  Future<void> markAllAsRead() async {
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(NotificationsFailure(errorMessage: 'User ID not found'));
        return;
      }
      await notificationRepo.markAllAsRead(userId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Delete a notification by ID
  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepo.deleteNotification(notificationId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> resetNotificationsCount() async {
    try {
      if (state is NotificationsSuccess) {
        final currentState = state as NotificationsSuccess;

        final updatedNotifications = currentState.notifications
            .map((n) => n.copyWith(isRead: true))
            .toList();

        // 🔑 emit immediately with all read
        emit(NotificationsSuccess(notifications: updatedNotifications));
      }
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Get unread notifications count
  Future<int> getUnreadCount() async {
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) return 0;
      return await notificationRepo.getUnreadCount(userId);
    } catch (e) {
      return 0;
    }
  }
}
