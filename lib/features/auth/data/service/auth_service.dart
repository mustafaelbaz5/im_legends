import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/service/supa_base_service.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../notification/data/service/firebase_notifications_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/user_data.dart';

class AuthService {
  final SupaBaseService _supaBaseService = SupaBaseService();

  static Future<bool> isLoggedIn() async {
    String? token = await SecureStorage().getToken();
    return token != null && token.isNotEmpty;
  }

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
      final response = await _supaBaseService.signUpUser(
        email: userData.email,
        password: password,
      );

      final uid = response.user?.id;
      if (uid == null) {
        throw Exception('Sign-up failed: UID not found.');
      }

      // 2. Upload profile image if provided
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await _supaBaseService.uploadProfileImage(profileImage, uid);
      }

      // 3. Insert user profile into 'users' table
      final updatedUserData = userData.copyWith(profileImageUrl: imageUrl);
      await _supaBaseService.insertUserData(updatedUserData.toMap(uid));

      // 4. Save FCM token for this user
      await FirebaseNotificationsService().initialize(uid);

      debugPrint('✅ Sign-up successful: $uid');
      return response;
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
      final response = await _supaBaseService.loginUser(
        email: email,
        password: password,
      );
      if (response.user?.id == null) {
        throw Exception('Login failed: user not found.');
      }
      final uid = response.user!.id;

      // Initialize Firebase notifications
      await FirebaseNotificationsService().initialize(uid);

      debugPrint('✅ Login successful: $uid');
      return response;
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
      final user = _supaBaseService.currentUser;
      if (user != null) {
        await _supaBaseService.removeAllTokens(user.id);
      }

      await _supaBaseService.logoutUser();
      debugPrint('User logged out.');
    } catch (e) {
      debugPrint('❌ Logout error: $e');
      throw Exception('Logout failed: $e');
    }
  }

  /// ---------------------------
  /// GET CURRENT USER DATA
  /// ---------------------------
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    return await _supaBaseService.fetchCurrentUserData();
  }

  /// ---------------------------
  /// GET USER SESSION DATA BY ID
  /// ---------------------------
  Future<Map<String, dynamic>?> getUserDataById(String userId) async {
    return await _supaBaseService.fetchUserProfileById(userId);
  }
}
