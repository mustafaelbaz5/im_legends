import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/notification/data/models/notification_model.dart';
import '../utils/secure_storage.dart';

class SupaBaseService {
  final supabase = Supabase.instance.client;
  final SecureStorage secureStorage = SecureStorage();

  /// ---------------------------
  /// USER DATA METHODS
  /// ---------------------------
  // Insert user data
  Future<void> insertUserData(Map<String, dynamic> userData) async {
    try {
      await supabase.from('users').insert(userData);
      debugPrint('✅ User profile inserted successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Database error inserting user profile: ${e.message}");
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error inserting user profile: $e");
      throw Exception('Unexpected error inserting user profile: $e');
    }
  }

  // Fetch user data by Id
  Future<Map<String, dynamic>?> fetchUserProfileById(String userId) async {
    try {
      final response = await supabase
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

  /// Fetch current user data
  Future<Map<String, dynamic>?> fetchCurrentUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      // Fetch user profile
      final userResponse = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      // Fetch tokens
      final tokensResponse = await supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', user.id);

      // Fetch notifications
      final notificationsResponse = await supabase
          .from('user_notifications')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return {
        'user': userResponse,
        'tokens': List<String>.from(
          tokensResponse.map((row) => row['token'] as String),
        ),
        'notifications': notificationsResponse.map((row) {
          return {
            'id': row['notification_id'],
            'title': row['title'],
            'message': row['message'],
            'created_at': row['created_at'],
            'type': row['type'],
            'is_read': row['is_read'],
          };
        }).toList(),
      };
    } catch (e) {
      debugPrint("❌ Error fetching current user session data: $e");
      return null;
    }
  }

  /// ---------------------------
  /// AUTHENTICATION METHODS
  /// ---------------------------

  Future<AuthResponse> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final userId = response.user?.id;
      if (userId != null) {
        await secureStorage.saveUserId(userId);
      }

      debugPrint('✅ User signed up successfully: ${response.user?.id}');
      return response;
    } on AuthException catch (e) {
      debugPrint("❌ Sign-up failed: ${e.message}");
      throw Exception('Sign-up failed: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error during sign-up: $e");
      throw Exception('Unexpected error during sign-up: $e');
    }
  }

  Future<AuthResponse> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userId = response.user?.id;
      if (userId != null) {
        await secureStorage.saveUserId(userId);
      }

      debugPrint('✅ User logged in successfully: ${response.user?.id}');
      return response;
    } on AuthException catch (e) {
      debugPrint("❌ Login failed: ${e.message}");
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error during login: $e");
      throw Exception('Unexpected error during login: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      await supabase.auth.signOut();

      debugPrint('✅ User logged out successfully');
    } catch (e) {
      debugPrint("❌ Error during logout: $e");
      throw Exception('Error during logout: $e');
    }
  }

  User? get currentUser => supabase.auth.currentUser;

  /// ---------------------------
  /// STORAGE METHODS
  /// ---------------------------

  Future<String> uploadProfileImage(File imageFile, String userId) async {
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$userId/$fileName';

    try {
      await supabase.storage.from('profile_images').upload(filePath, imageFile);
      final publicUrl = supabase.storage
          .from('profile_images')
          .getPublicUrl(filePath);
      debugPrint('✅ Profile image uploaded successfully: $publicUrl');
      return publicUrl;
    } on StorageException catch (e) {
      debugPrint("❌ Failed to upload profile image: ${e.message}");
      throw Exception('Failed to upload profile image: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error while uploading profile image: $e");
      throw Exception('Unexpected error while uploading profile image: $e');
    }
  }

  Future<void> deleteProfileImage(String filePath) async {
    try {
      await supabase.storage.from('profile_images').remove([filePath]);
      debugPrint('✅ Profile image deleted successfully: $filePath');
    } on StorageException catch (e) {
      debugPrint("❌ Failed to delete profile image: ${e.message}");
      throw Exception('Failed to delete profile image: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error while deleting profile image: $e");
      throw Exception('Unexpected error while deleting profile image: $e');
    }
  }

  /// ---------------------------
  /// TOKEN MANAGEMENT METHODS
  /// ---------------------------

  Future<void> saveOrUpdateToken(String userId, String token) async {
    try {
      // First, check if token already exists
      final existingTokens = await supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', userId)
          .eq('token', token);

      if (existingTokens.isEmpty) {
        // Token doesn't exist, insert it
        await supabase.from('user_tokens').upsert({
          'user_id': userId,
          'token': token,
          'created_at': DateTime.now().toIso8601String(),
        });
        debugPrint('✅ New FCM token saved successfully');
      } else {
        // Token already exists, update timestamp
        await supabase
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

  Future<List<String>> getUserTokens(String userId) async {
    try {
      final response = await supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', userId);

      return List<String>.from(response.map((row) => row['token'] as String));
    } catch (e) {
      debugPrint("❌ Error fetching user tokens: $e");
      return [];
    }
  }

  Future<void> removeUserToken(String userId, String token) async {
    try {
      await supabase
          .from('user_tokens')
          .delete()
          .eq('user_id', userId)
          .eq('token', token);
      debugPrint('✅ User token removed successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to remove user token: ${e.message}");
      throw Exception('Failed to remove user token: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error removing user token: $e");
      throw Exception('Unexpected error removing user token: $e');
    }
  }

  Future<void> removeAllTokens(String userId) async {
    try {
      await supabase.from('user_tokens').delete().eq('user_id', userId);
      debugPrint('✅ All user tokens removed successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to remove all user tokens: ${e.message}");
      throw Exception('Failed to remove all user tokens: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error removing all user tokens: $e");
      throw Exception('Unexpected error removing all user tokens: $e');
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
      await supabase
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
      await supabase.from('user_notifications').insert({
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
      final response = await supabase
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
      await supabase
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
      await supabase
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
