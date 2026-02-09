import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_error.dart';
import '../models/error_details.dart';
import '../types/error_type.dart';

/// Supabase Error Handler
///
/// Converts Supabase exceptions to AppError
/// Works with: Supabase Auth, Database, Storage, etc.
class SupabaseErrorHandler {
  /// Main entry point for handling Supabase errors
  static AppError handle(final dynamic error) {
    if (error is AuthException) {
      return _handleAuthException(error);
    }

    if (error is PostgrestException) {
      return _handlePostgrestException(error);
    }

    if (error is StorageException) {
      return _handleStorageException(error);
    }

    return AppError.unknown(error.toString());
  }

  // ============================================
  // Supabase Auth Exceptions
  // ============================================

  static AppError _handleAuthException(final AuthException error) {
    final serverMessage = error.message;
    final code = int.tryParse(error.statusCode ?? '');

    // Check for specific error messages
    final messageLower = serverMessage.toLowerCase();

    // Invalid credentials
    if (messageLower.contains('invalid') &&
        (messageLower.contains('credentials') ||
            messageLower.contains('email') ||
            messageLower.contains('password'))) {
      return AppError(
        messageKey: 'errors.invalid_credentials',
        serverMessage: serverMessage,
        type: ErrorType.unauthorized,
        code: code ?? ErrorCode.unauthorized,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // User not found
    if (messageLower.contains('user') &&
        (messageLower.contains('not found') ||
            messageLower.contains('does not exist'))) {
      return AppError(
        messageKey: 'errors.user_not_found',
        serverMessage: serverMessage,
        type: ErrorType.notFound,
        code: code ?? ErrorCode.notFound,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Email already exists
    if (messageLower.contains('email') &&
        (messageLower.contains('already') ||
            messageLower.contains('exists') ||
            messageLower.contains('registered'))) {
      return AppError(
        messageKey: 'errors.email_already_exists',
        serverMessage: serverMessage,
        type: ErrorType.conflict,
        code: code ?? ErrorCode.conflict,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Weak password
    if (messageLower.contains('password') &&
        (messageLower.contains('weak') ||
            messageLower.contains('short') ||
            messageLower.contains('must be'))) {
      return AppError(
        messageKey: 'errors.weak_password',
        serverMessage: serverMessage,
        type: ErrorType.validation,
        code: code ?? ErrorCode.badRequest,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Invalid email format
    if (messageLower.contains('email') && messageLower.contains('invalid')) {
      return AppError(
        messageKey: 'errors.invalid_email',
        serverMessage: serverMessage,
        type: ErrorType.validation,
        code: code ?? ErrorCode.badRequest,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Email not verified
    if (messageLower.contains('email') &&
        (messageLower.contains('not verified') ||
            messageLower.contains('verify'))) {
      return AppError(
        messageKey: 'errors.email_not_verified',
        serverMessage: serverMessage,
        type: ErrorType.unauthorized,
        code: code ?? ErrorCode.unauthorized,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Session expired
    if (messageLower.contains('session') ||
        messageLower.contains('token') ||
        messageLower.contains('expired')) {
      return AppError(
        messageKey: 'errors.session_expired',
        serverMessage: serverMessage,
        type: ErrorType.unauthorized,
        code: code ?? ErrorCode.unauthorized,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Too many requests
    if (messageLower.contains('too many') ||
        messageLower.contains('rate limit')) {
      return AppError(
        messageKey: 'errors.too_many_requests',
        serverMessage: serverMessage,
        type: ErrorType.tooManyRequests,
        code: code ?? ErrorCode.tooManyRequests,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    // Map by status code if no specific message pattern matched
    return _mapByStatusCode(
      code: code,
      serverMessage: serverMessage,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  // ============================================
  // Supabase Postgrest (Database) Exceptions
  // ============================================

  static AppError _handlePostgrestException(final PostgrestException error) {
    final serverMessage = error.message;
    final code = _parsePostgrestCode(error.code);
    final hint = error.hint;
    final details = error.details;

    // Build technical message with all available info
    final technicalParts = <String>[
      'Code: ${error.code}',
      if (hint != null) 'Hint: $hint',
      if (details != null) 'Details: $details',
    ];

    final technicalMessage = technicalParts.join(' | ');

    // Check for specific PostgreSQL error codes
    switch (error.code) {
      // Unique violation (duplicate key)
      case '23505':
        return AppError(
          messageKey: 'errors.conflict',
          serverMessage: serverMessage,
          type: ErrorType.conflict,
          code: ErrorCode.conflict,
          technicalMessage: technicalMessage,
          details: ErrorDetails(
            metadata: {'code': error.code, 'hint': hint, 'details': details},
          ),
          originalError: error,
        );

      // Foreign key violation
      case '23503':
        return AppError(
          messageKey: 'errors.bad_request',
          serverMessage: serverMessage,
          type: ErrorType.badRequest,
          code: ErrorCode.badRequest,
          technicalMessage: technicalMessage,
          originalError: error,
        );

      // Not null violation
      case '23502':
        return AppError(
          messageKey: 'errors.validation',
          serverMessage: serverMessage,
          type: ErrorType.validation,
          code: ErrorCode.badRequest,
          technicalMessage: technicalMessage,
          originalError: error,
        );

      // Check violation
      case '23514':
        return AppError(
          messageKey: 'errors.validation',
          serverMessage: serverMessage,
          type: ErrorType.validation,
          code: ErrorCode.badRequest,
          technicalMessage: technicalMessage,
          originalError: error,
        );

      // Permission denied (insufficient privilege)
      case '42501':
        return AppError(
          messageKey: 'errors.permission_denied',
          serverMessage: serverMessage,
          type: ErrorType.forbidden,
          code: ErrorCode.forbidden,
          technicalMessage: technicalMessage,
          originalError: error,
        );

      // Default
      default:
        return AppError(
          messageKey: 'errors.server_error',
          serverMessage: serverMessage,
          type: ErrorType.internalServer,
          code: code ?? ErrorCode.internalServer,
          technicalMessage: technicalMessage,
          details: ErrorDetails(
            metadata: {'code': error.code, 'hint': hint, 'details': details},
          ),
          originalError: error,
        );
    }
  }

  // ============================================
  // Supabase Storage Exceptions
  // ============================================

  static AppError _handleStorageException(final StorageException error) {
    final serverMessage = error.message;
    final statusCode = error.statusCode;

    // Check for specific storage errors
    if (serverMessage.toLowerCase().contains('not found')) {
      return AppError(
        messageKey: 'errors.not_found',
        serverMessage: serverMessage,
        type: ErrorType.notFound,
        code: statusCode != null ? int.parse(statusCode) : ErrorCode.notFound,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (serverMessage.toLowerCase().contains('too large') ||
        serverMessage.toLowerCase().contains('size')) {
      return AppError(
        messageKey: 'errors.file_too_large',
        serverMessage: serverMessage,
        type: ErrorType.badRequest,
        code: statusCode != null ? int.parse(statusCode) : ErrorCode.badRequest,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    if (serverMessage.toLowerCase().contains('permission') ||
        serverMessage.toLowerCase().contains('unauthorized')) {
      return AppError(
        messageKey: 'errors.permission_denied',
        serverMessage: serverMessage,
        type: ErrorType.forbidden,
        code: statusCode != null ? int.parse(statusCode) : ErrorCode.forbidden,
        technicalMessage: error.message,
        originalError: error,
      );
    }

    return _mapByStatusCode(
      code: statusCode != null ? int.parse(statusCode) : null,
      serverMessage: serverMessage,
      technicalMessage: error.message,
      originalError: error,
    );
  }

  // ============================================
  // Helper Methods
  // ============================================

  /// Map errors by HTTP status code when specific patterns don't match
  static AppError _mapByStatusCode({
    required final int? code,
    required final String serverMessage,
    required final String technicalMessage,
    required final dynamic originalError,
  }) {
    switch (code) {
      case 400:
        return AppError(
          messageKey: 'errors.bad_request',
          serverMessage: serverMessage,
          type: ErrorType.badRequest,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 401:
        return AppError(
          messageKey: 'errors.unauthorized',
          serverMessage: serverMessage,
          type: ErrorType.unauthorized,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 403:
        return AppError(
          messageKey: 'errors.forbidden',
          serverMessage: serverMessage,
          type: ErrorType.forbidden,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 404:
        return AppError(
          messageKey: 'errors.not_found',
          serverMessage: serverMessage,
          type: ErrorType.notFound,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 409:
        return AppError(
          messageKey: 'errors.conflict',
          serverMessage: serverMessage,
          type: ErrorType.conflict,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 422:
        return AppError(
          messageKey: 'errors.validation',
          serverMessage: serverMessage,
          type: ErrorType.validation,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 429:
        return AppError(
          messageKey: 'errors.too_many_requests',
          serverMessage: serverMessage,
          type: ErrorType.tooManyRequests,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      case 500:
      case 502:
      case 503:
        return AppError(
          messageKey: 'errors.server_error',
          serverMessage: serverMessage,
          type: ErrorType.internalServer,
          code: code,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );

      default:
        return AppError(
          messageKey: 'errors.unknown',
          serverMessage: serverMessage,
          type: ErrorType.unknown,
          code: code ?? ErrorCode.unknown,
          technicalMessage: technicalMessage,
          originalError: originalError,
        );
    }
  }

  /// Parse Postgrest error code to integer if possible
  static int? _parsePostgrestCode(final String? code) {
    if (code == null) return null;
    try {
      return int.parse(code);
    } catch (_) {
      return null;
    }
  }
}
