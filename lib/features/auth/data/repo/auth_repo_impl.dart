import 'dart:io';

import 'package:im_legends/features/auth/data/remote/auth_remote_ds.dart';
import 'package:im_legends/features/auth/data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/user_data.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDS remoteDS;

  AuthRepoImpl({required this.remoteDS});

  @override
  Future<AuthResponse> signUp({
    required final UserData userData,
    required final String password,
    final File? profileImage,
  }) async {
    try {
      return await remoteDS.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> login({
    required final String email,
    required final String password,
  }) async {
    try {
      return await remoteDS.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDS.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserData?> getUserDataById(final String uid) async {
    try {
      return await remoteDS.fetchUserDataById(uid);
    } catch (e) {
      rethrow;
    }
  }
}
