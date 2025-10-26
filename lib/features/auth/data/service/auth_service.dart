import 'dart:io';
import 'package:flutter/material.dart';
import 'package:im_legends/core/service/image_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../notification/data/service/firebase_notifications_service.dart';
import '../../../../core/models/user_data.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  final SecureStorage _secureStorage = SecureStorage();

  static Future<bool> isLoggedIn() async {
    String? token = await SecureStorage().getToken();
    return token != null && token.isNotEmpty;
  }

  User? get currentUser => _supabase.auth.currentUser;

  /// ---------------------------
  /// SIGN UP
  /// ---------------------------
  Future<AuthResponse> signUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    try {
      // 1. Create user in Supabase Auth
      final response = await _supabase.auth.signUp(
        email: userData.email,
        password: password,
      );

      final userId = response.user?.id;
      if (userId != null) {
        await _secureStorage.saveUserId(userId);
      }

      final uid = response.user?.id;
      if (uid == null) {
        throw Exception('Sign-up failed: UID not found.');
      }

      debugPrint('✅ User signed up successfully: $uid');

      // 2. Upload profile image if provided
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await ImageService().uploadProfileImage(profileImage, uid);
      }

      // 3. Insert user profile into 'users' table
      final updatedUserData = userData.copyWith(profileImageUrl: imageUrl);
      await _supabase.from('users').insert(updatedUserData.toMap(uid));
      debugPrint('✅ User profile inserted successfully');

      // 4. Save FCM token for this user
      await FirebaseNotificationsService().initialize(uid);

      debugPrint('✅ Sign-up successful: $uid');
      return response;
    } on AuthException catch (e) {
      debugPrint("❌ Sign-up failed: ${e.message}");
      throw Exception('Sign-up failed: ${e.message}');
    } on StorageException catch (e) {
      debugPrint("❌ Failed to upload profile image: ${e.message}");
      throw Exception('Failed to upload profile image: ${e.message}');
    } on PostgrestException catch (e) {
      debugPrint("❌ Database error inserting user profile: ${e.message}");
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Sign-up error: $e');
      throw Exception('Sign-up failed: $e');
    }
  }

  /// ---------------------------
  /// LOGIN
  /// ---------------------------
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final userId = response.user?.id;
      if (userId != null) {
        await _secureStorage.saveUserId(userId);
      }

      if (response.user?.id == null) {
        throw Exception('Login failed: user not found.');
      }
      final uid = response.user!.id;

      debugPrint('✅ User logged in successfully: $uid');

      // Initialize Firebase notifications
      await FirebaseNotificationsService().initialize(uid);

      debugPrint('✅ Login successful: $uid');
      return response;
    } on AuthException catch (e) {
      debugPrint("❌ Login failed: ${e.message}");
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      debugPrint('❌ Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  Future<void> logout() async {
    try {
      final user = currentUser;
      if (user != null) {
        // Remove all tokens
        await _supabase.from('user_tokens').delete().eq('user_id', user.id);
        debugPrint('✅ All user tokens removed successfully');
      }

      // Sign out
      await _supabase.auth.signOut();
      debugPrint('✅ User logged out successfully');
    } on PostgrestException catch (e) {
      debugPrint("❌ Failed to remove all user tokens: ${e.message}");
      throw Exception('Failed to remove all user tokens: ${e.message}');
    } catch (e) {
      debugPrint('❌ Logout error: $e');
      throw Exception('Logout failed: $e');
    }
  }

  /// ---------------------------
  /// GET CURRENT USER DATA
  /// ---------------------------
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      // Fetch user profile
      final userResponse = await _supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      // Fetch tokens
      final tokensResponse = await _supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', user.id);

      // Fetch notifications
      final notificationsResponse = await _supabase
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
  /// GET USER SESSION DATA BY ID
  /// ---------------------------
  Future<Map<String, dynamic>?> getUserDataById(String userId) async {
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
}
