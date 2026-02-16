import 'auth_error_model.dart';

class AuthResult<T> {
  final T? data;
  final AuthErrorModel? error;
  final bool isSuccess;

  const AuthResult._({this.data, this.error, this.isSuccess = false});

  /// Create a successful result
  factory AuthResult.success(T data) {
    return AuthResult._(data: data, isSuccess: true);
  }

  /// Create a failed result
  factory AuthResult.failure(AuthErrorModel error) {
    return AuthResult._(error: error, isSuccess: false);
  }

  /// Check if the result is a failure
  bool get isFailure => !isSuccess;
}
