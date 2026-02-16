import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/notification/data/models/notification_model.dart';
import '../storage/secure_storage.dart';

class SupaBaseService {
  final _supabase = Supabase.instance.client;
  final SecureStorage secureStorage = SecureStorage();

  // Fetch user data by Id
  Future<Map<String, dynamic>?> fetchUserProfileById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      debugPrint("❌ Error fetching user session data: $e");
      return null;
    }
  }

  /// ---------------------------
  /// TOKEN MANAGEMENT METHODS
  /// ---------------------------

  Future<void> saveOrUpdateToken(String userId, String token) async {
    try {
      // First, check if token already exists
      final existingTokens = await _supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', userId)
          .eq('token', token);

      if (existingTokens.isEmpty) {
        // Token doesn't exist, insert it
        await _supabase.from('user_tokens').upsert({
          'user_id': userId,
          'token': token,
          'created_at': DateTime.now().toIso8601String(),
        });
        debugPrint('✅ New FCM token saved successfully');
      } else {
        // Token already exists, update timestamp
        await _supabase
            .from('user_tokens')
            .update({'updated_at': DateTime.now().toIso8601String()})
            .eq('user_id', userId)
            .eq('token', token);
        debugPrint('✅ FCM token updated successfully');
      }
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to save/update FCM token: ${e.message}");
      throw Exception('Failed to save/update FCM token: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error saving/updating FCM token: $e");
      throw Exception('Unexpected error saving/updating FCM token: $e');
    }
  }

  /// ---------------------------
  /// NOTIFICATION METHODS
  /// ---------------------------

  // Method 1: Insert using model
  Future<void> insertNotificationFromModel(
    NotificationModel notification,
  ) async {
    try {
      await _supabase
          .from('user_notifications')
          .insert(notification.toSupabase());
      debugPrint('✅ Notification inserted successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to insert notification: ${e.message}");
      throw Exception('Failed to insert notification: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error inserting notification: $e");
      throw Exception('Unexpected error inserting notification: $e');
    }
  }

  // Method 2: Insert with parameters (your existing method, updated)
  Future<void> insertNotification({
    required String userId,
    required String title,
    required String message,
    required NotificationType type, // Changed to enum
    String? notificationId,
  }) async {
    try {
      await _supabase.from('user_notifications').insert({
        'user_id': Supabase.instance.client.auth.currentUser!.id,
        'notification_id':
            notificationId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'message': message,
        'type': type.name, // Store as string
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
      });
      debugPrint('✅ Notification inserted successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to insert notification: ${e.message}");
      throw Exception('Failed to insert notification: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error inserting notification: $e");
      throw Exception('Unexpected error inserting notification: $e');
    }
  }

  // Updated get method using the model
  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    try {
      final response = await _supabase
          .from('user_notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((row) {
        return NotificationModel.fromSupabase(row);
      }).toList();
    } catch (e) {
      debugPrint("❌ Error fetching user notifications: $e");
      return [];
    }
  }

  // Additional helpful methods
  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabase
          .from('user_notifications')
          .update({'is_read': true})
          .eq('notification_id', notificationId);
      debugPrint('✅ Notification marked as read');
    } catch (e) {
      debugPrint("❌ Error marking notification as read: $e");
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _supabase
          .from('user_notifications')
          .delete()
          .eq('notification_id', notificationId);
      debugPrint('✅ Notification deleted successfully');
    } catch (e) {
      debugPrint("❌ Error deleting notification: $e");
      throw Exception('Failed to delete notification: $e');
    }
  }
}
