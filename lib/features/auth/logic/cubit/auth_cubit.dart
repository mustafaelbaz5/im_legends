import 'dart:io';
import 'package:bloc/bloc.dart';
import '../../../../core/error/auth_error_model.dart';
import 'package:meta/meta.dart';
import '../../data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> emitSignUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );
      emit(AuthSuccess(authResponse: response, userData: userData));
    } on AuthErrorModel catch (e) {
      emit(AuthFailure(errorMessage: e.userMessage));
    } catch (e) {
      emit(
        AuthFailure(
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  Future<void> emitLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.login(email: email, password: password);
      final userDataMap = await authRepo.getUserDataById(response.user!.id);

      final userData = userDataMap != null
          ? UserData(
              name: userDataMap['name'] ?? '',
              email: userDataMap['email'] ?? '',
              phoneNumber: userDataMap['phone_number'] ?? '',
              age: userDataMap['age'] ?? 0,
              profileImageUrl: userDataMap['profile_image'],
            )
          : null;

      emit(AuthSuccess(authResponse: response, userData: userData));
    } on AuthErrorModel catch (e) {
      emit(AuthFailure(errorMessage: e.userMessage));
    } catch (e) {
      emit(
        AuthFailure(
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }
}
