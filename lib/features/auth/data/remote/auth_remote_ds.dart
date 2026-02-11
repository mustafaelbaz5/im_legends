import 'dart:io';

import 'package:im_legends/core/error/types/error_handler.dart';
import 'package:im_legends/core/models/user_data.dart';
import 'package:im_legends/core/networking/supabase_service.dart';
import 'package:im_legends/core/service/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_remote_ds.dart';
import 'user_remote_ds.dart';

class AuthRemoteDS {
  final SupabaseService supabaseService;
  final SecureStorage secureStorage;
  final StorageRemoteDS storageRemoteDS;
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

      await secureStorage.write(key: 'userId', value: uid);

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

      await secureStorage.write(key: 'userId', value: uid);

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
      await secureStorage.delete(key: 'userId');
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
