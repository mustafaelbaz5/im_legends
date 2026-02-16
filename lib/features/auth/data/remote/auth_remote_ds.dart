import 'dart:io';

import '../../../../core/config/app_constants.dart';
import '../../../../core/error/types/error_handler.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/networking/supabase_service.dart';
import '../../../../core/service/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/networking/storage_remote_ds.dart';
import '../../../../core/networking/user_remote_ds.dart';

class AuthRemoteDS {
  final SupabaseService supabaseService;
  final SecureStorage secureStorage;
  final StorageRemoteDs storageRemoteDS;
  final UserRemoteDS userRemoteDS;

  AuthRemoteDS({
    required this.supabaseService,
    required this.secureStorage,
    required this.storageRemoteDS,
    required this.userRemoteDS,
  });

  /// Sign-up flow
  Future<AuthResponse> signUp({
    required final UserData userData,
    required final String password,
    final File? profileImage,
  }) async {
    try {
      final response = await supabaseService.client.auth.signUp(
        email: userData.email,
        password: password,
      );

      final uid = response.user?.id;
      if (uid == null) throw Exception('Sign-up failed: UID not found.');

      await secureStorage.write(key: AppConstants.userIdKey, value: uid);

      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await storageRemoteDS.uploadAndSetProfileImage(
          uid,
          profileImage,
        );
      }

      final updatedUserData = userData.copyWith(profileImageUrl: imageUrl);
      await userRemoteDS.insertUserProfile(updatedUserData, uid);

      return response;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Login flow
  Future<AuthResponse> login({
    required final String email,
    required final String password,
  }) async {
    try {
      final response = await supabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final uid = response.user?.id;
      if (uid == null) throw Exception('Login failed: user not found.');

      await secureStorage.write(key: AppConstants.userIdKey, value: uid);

      return response;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      final uid = supabaseService.currentUser?.id;
      if (uid != null) await removeAllTokens(uid);

      await supabaseService.signOut();
      await secureStorage.delete(key: AppConstants.userIdKey);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Remove all tokens
  Future<void> removeAllTokens(final String uid) async {
    try {
      await supabaseService.client
          .from('user_tokens')
          .delete()
          .eq('user_id', uid);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Fetch user profile by UID
  Future<UserData?> fetchUserDataById(final String uid) async {
    return await userRemoteDS.fetchUserDataById(uid);
  }
}
