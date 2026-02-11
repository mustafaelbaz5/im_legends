import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:im_legends/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/models/app_error.dart';
import '../../../../core/models/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> signUp({
    required final UserData userData,
    required final String password,
    final File? profileImage,
  }) async {
    emit(AuthLoading());
    try {
      final AuthResponse response = await authRepo.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );

      // Emit success with user data
      emit(AuthSuccess(authResponse: response, userData: userData));
    } catch (error) {
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }

  Future<void> login({
    required final String email,
    required final String password,
  }) async {
    emit(AuthLoading());
    try {
      final AuthResponse response = await authRepo.login(
        email: email,
        password: password,
      );

      final UserData? userData = await _fetchUserData(response.user?.id);

      emit(AuthSuccess(authResponse: response, userData: userData));
    } catch (error) {
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepo.logout();
      emit(AuthLoggedOut());
    } catch (error) {
      emit(AuthFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }

  Future<UserData?> _fetchUserData(final String? uid) async {
    if (uid == null) return null;
    try {
      return await authRepo.getUserDataById(uid);
    } catch (_) {
      return null;
    }
  }
}
