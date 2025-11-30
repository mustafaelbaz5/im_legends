import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/auth_error.dart';
import '../../../../core/error/auth_error_model.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/service/image_service.dart';
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
        throw const AuthErrorModel(
          message: 'Sign-up failed: UID not found',
          userMessage: 'Failed to create your account. Please try again.',
          type: AuthErrorType.unknown,
        );
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
    } catch (e) {
      final authError = AuthErrorHandler.handle(e);
      debugPrint("❌ Sign-up failed: ${authError.message}");
      throw authError;
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
        throw const AuthErrorModel(
          message: 'Login failed: user not found',
          userMessage: 'Login failed. Please check your credentials.',
          type: AuthErrorType.userNotFound,
        );
      }
      final uid = response.user!.id;

      debugPrint('✅ User logged in successfully: $uid');

      // Initialize Firebase notifications
      await FirebaseNotificationsService().initialize(uid);

      debugPrint('✅ Login successful: $uid');
      return response;
    } catch (e) {
      final authError = AuthErrorHandler.handle(e);
      debugPrint("❌ Login failed: ${authError.message}");
      throw authError;
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
    } catch (e) {
      final authError = AuthErrorHandler.handle(e);
      debugPrint('❌ Logout error: ${authError.message}');
      throw authError;
    }
  }

  /// ---
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
      final authError = AuthErrorHandler.handle(e);
      debugPrint("❌ Error fetching user session data: ${authError.message}");
      return null;
    }
  }
}
