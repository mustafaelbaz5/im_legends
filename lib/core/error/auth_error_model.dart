
import 'auth_error.dart';

class AuthErrorModel implements Exception {
  final String message;
  final String userMessage;
  final AuthErrorType type;

  const AuthErrorModel({
    required this.message,
    required this.userMessage,
    required this.type,
  });

  @override
  String toString() => 'AuthError: $message';
}
