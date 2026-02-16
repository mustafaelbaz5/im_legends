import 'dart:io';
<<<<<<< HEAD

import '../../../../core/models/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<AuthResponse> signUp({
    required final UserData userData,
    required final String password,
    final File? profileImage,
  });
=======
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/auth_error.dart';
import '../../../../core/error/auth_error_model.dart';
import '../../../../core/models/user_data.dart';
import '../service/auth_service.dart';

class AuthRepo {
  final AuthService _authService;

  AuthRepo({AuthService? authService})
    : _authService = authService ?? AuthService();

  /// Sign up user and return their data
  Future<AuthResponse> signUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    try {
      return await _authService.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );
    } on AuthErrorModel catch (e) {
      debugPrint('❌ Repository: Sign-up failed - ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('❌ Repository: Unexpected sign-up error: $e\n$stackTrace');
      final authError = AuthErrorHandler.handle(e);
      throw authError;
    }
  }
>>>>>>> 2fa39781c29902b318aa4aca4eb042af1f00eebd

  Future<AuthResponse> login({
<<<<<<< HEAD
    required final String email,
    required final String password,
  });

  Future<void> logout();

  Future<UserData?> getUserDataById(final String uid);
=======
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.login(email: email, password: password);
    } on AuthErrorModel catch (e) {
      debugPrint('❌ Repository: Login failed - ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('❌ Repository: Unexpected login error: $e\n$stackTrace');
      final authError = AuthErrorHandler.handle(e);
      throw authError;
    }
  }

  /// Fetch user data by user ID
  Future<Map<String, dynamic>?> getUserDataById(String userId) async {
    try {
      return await _authService.getUserDataById(userId);
    } on AuthErrorModel catch (e) {
      debugPrint('❌ Repository: Failed to fetch user data - ${e.message}');
      return null;
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Repository: Unexpected error fetching user data: $e\n$stackTrace',
      );
      return null;
    }
  }
>>>>>>> 2fa39781c29902b318aa4aca4eb042af1f00eebd
}
