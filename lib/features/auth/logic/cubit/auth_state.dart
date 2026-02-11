part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponse authResponse;
  final UserData? userData;

  AuthSuccess({required this.authResponse, this.userData});
}

final class AuthLoggedOut extends AuthState {}

final class AuthFailure extends AuthState {
  final AppError error;
  AuthFailure({required this.error});
}
