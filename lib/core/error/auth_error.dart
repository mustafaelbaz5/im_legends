import 'auth_error_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Types of authentication errors
enum AuthErrorType {
  // Auth errors
  invalidCredentials,
  userNotFound,
  emailAlreadyInUse,
  weakPassword,
  invalidEmail,
  tooManyRequests,
  emailNotConfirmed,
  sessionExpired,
  unauthorized,

  // Database errors
  databaseError,
  userProfileNotFound,
  insertError,
  updateError,
  deleteError,

  // Storage errors
  storageError,
  uploadFailed,
  deleteFailed,

  // Network errors
  networkError,
  timeout,

  // General errors
  unknown,
}

/// Handler class for authentication errors
class AuthErrorHandler {
  /// Handle Supabase AuthException
  static AuthErrorModel handleAuthException(AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return const AuthErrorModel(
        message: 'Invalid login credentials',
        userMessage:
            'The email or password you entered is incorrect. Please try again.',
        type: AuthErrorType.invalidCredentials,
      );
    }

    if (message.contains('user not found')) {
      return const AuthErrorModel(
        message: 'User not found',
        userMessage: 'No account found with this email address.',
        type: AuthErrorType.userNotFound,
      );
    }

    if (message.contains('email already registered') ||
        message.contains('user already registered')) {
      return const AuthErrorModel(
        message: 'Email already in use',
        userMessage:
            'An account with this email already exists. Please sign in or use a different email.',
        type: AuthErrorType.emailAlreadyInUse,
      );
    }

    if (message.contains('password') && message.contains('weak')) {
      return const AuthErrorModel(
        message: 'Weak password',
        userMessage:
            'Your password is too weak. Please use at least 8 characters with a mix of letters and numbers.',
        type: AuthErrorType.weakPassword,
      );
    }

    if (message.contains('invalid email')) {
      return const AuthErrorModel(
        message: 'Invalid email',
        userMessage: 'Please enter a valid email address.',
        type: AuthErrorType.invalidEmail,
      );
    }

    if (message.contains('email not confirmed')) {
      return const AuthErrorModel(
        message: 'Email not confirmed',
        userMessage:
            'Please verify your email address before signing in. Check your inbox for the confirmation link.',
        type: AuthErrorType.emailNotConfirmed,
      );
    }

    if (message.contains('too many requests')) {
      return const AuthErrorModel(
        message: 'Too many requests',
        userMessage:
            'Too many attempts. Please wait a few minutes before trying again.',
        type: AuthErrorType.tooManyRequests,
      );
    }

    if (message.contains('session') && message.contains('expired')) {
      return const AuthErrorModel(
        message: 'Session expired',
        userMessage: 'Your session has expired. Please sign in again.',
        type: AuthErrorType.sessionExpired,
      );
    }

    if (message.contains('unauthorized')) {
      return const AuthErrorModel(
        message: 'Unauthorized',
        userMessage: 'You are not authorized to perform this action.',
        type: AuthErrorType.unauthorized,
      );
    }

    // Default auth error
    return AuthErrorModel(
      message: e.message,
      userMessage: 'Authentication failed. Please try again.',
      type: AuthErrorType.unknown,
    );
  }

  /// Handle Supabase PostgrestException
  static AuthErrorModel handleDatabaseException(PostgrestException e) {
    final message = e.message.toLowerCase();

    if (message.contains('duplicate key') ||
        message.contains('unique constraint')) {
      return const AuthErrorModel(
        message: 'Duplicate entry',
        userMessage: 'This information already exists in our system.',
        type: AuthErrorType.insertError,
      );
    }

    if (message.contains('foreign key constraint')) {
      return const AuthErrorModel(
        message: 'Related record not found',
        userMessage: 'Unable to complete this action. Please try again.',
        type: AuthErrorType.databaseError,
      );
    }

    if (message.contains('not found')) {
      return const AuthErrorModel(
        message: 'Record not found',
        userMessage: 'The requested information was not found.',
        type: AuthErrorType.userProfileNotFound,
      );
    }

    if (message.contains('permission denied')) {
      return const AuthErrorModel(
        message: 'Permission denied',
        userMessage: 'You do not have permission to perform this action.',
        type: AuthErrorType.unauthorized,
      );
    }

    // Default database error
    return AuthErrorModel(
      message: e.message,
      userMessage: 'A database error occurred. Please try again later.',
      type: AuthErrorType.databaseError,
    );
  }

  /// Handle Supabase StorageException
  static AuthErrorModel handleStorageException(StorageException e) {
    final message = e.message.toLowerCase();

    if (message.contains('file too large') || message.contains('size')) {
      return const AuthErrorModel(
        message: 'File too large',
        userMessage:
            'The image file is too large. Please choose a smaller image (max 5MB).',
        type: AuthErrorType.uploadFailed,
      );
    }

    if (message.contains('invalid file type') || message.contains('format')) {
      return const AuthErrorModel(
        message: 'Invalid file type',
        userMessage: 'Please upload a valid image file (JPG, PNG, or WEBP).',
        type: AuthErrorType.uploadFailed,
      );
    }

    if (message.contains('not found')) {
      return const AuthErrorModel(
        message: 'File not found',
        userMessage: 'The image could not be found.',
        type: AuthErrorType.storageError,
      );
    }

    if (message.contains('permission denied') ||
        message.contains('unauthorized')) {
      return const AuthErrorModel(
        message: 'Storage permission denied',
        userMessage: 'You do not have permission to upload images.',
        type: AuthErrorType.unauthorized,
      );
    }

    // Default storage error
    return AuthErrorModel(
      message: e.message,
      userMessage: 'Failed to upload image. Please try again.',
      type: AuthErrorType.storageError,
    );
  }

  /// Handle general exceptions
  static AuthErrorModel handleGeneralException(Object e) {
    final errorString = e.toString().toLowerCase();

    if (errorString.contains('socketexception') ||
        errorString.contains('network') ||
        errorString.contains('connection')) {
      return const AuthErrorModel(
        message: 'Network error',
        userMessage:
            'No internet connection. Please check your network and try again.',
        type: AuthErrorType.networkError,
      );
    }

    if (errorString.contains('timeout')) {
      return const AuthErrorModel(
        message: 'Request timeout',
        userMessage: 'The request took too long. Please try again.',
        type: AuthErrorType.timeout,
      );
    }

    // Default unknown error
    return AuthErrorModel(
      message: e.toString(),
      userMessage: 'An unexpected error occurred. Please try again.',
      type: AuthErrorType.unknown,
    );
  }

  /// Main error handler - automatically detects error type
  static AuthErrorModel handle(Object e) {
    if (e is AuthException) {
      return handleAuthException(e);
    } else if (e is PostgrestException) {
      return handleDatabaseException(e);
    } else if (e is StorageException) {
      return handleStorageException(e);
    } else if (e is AuthErrorModel) {
      return e;
    } else {
      return handleGeneralException(e);
    }
  }

  /// Get user-friendly error message
  static String getUserMessage(Object e) {
    return handle(e).userMessage;
  }

  /// Get error type
  static AuthErrorType getErrorType(Object e) {
    return handle(e).type;
  }
}
