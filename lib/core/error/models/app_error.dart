import 'package:easy_localization/easy_localization.dart';

import '../types/error_type.dart';
import 'error_details.dart';

class AppError implements Exception {
  /// User-friendly error message key (for translation)
  final String messageKey;

  /// Optional: Raw message from server (already in user's language)
  final String? serverMessage;

  /// Error type for handling logic
  final ErrorType type;

  /// HTTP status code or custom error code
  final int? code;

  /// Technical details for logging/debugging
  final String? technicalMessage;

  /// Additional structured error information
  final ErrorDetails? details;

  /// Original error for debugging
  final dynamic originalError;

  const AppError({
    required this.messageKey,
    this.serverMessage,
    required this.type,
    this.code,
    this.technicalMessage,
    this.details,
    this.originalError,
  });

  // Factory Constructors for Common Errors
  factory AppError.noInternet() {
    return const AppError(
      messageKey: 'errors.no_internet',
      type: ErrorType.noInternet,
      code: ErrorCode.noInternet,
    );
  }

  factory AppError.timeout() {
    return const AppError(
      messageKey: 'errors.timeout',
      type: ErrorType.timeout,
      code: ErrorCode.timeout,
    );
  }

  factory AppError.unauthorized([final String? serverMessage]) {
    return AppError(
      messageKey: 'errors.unauthorized',
      serverMessage: serverMessage,
      type: ErrorType.unauthorized,
      code: ErrorCode.unauthorized,
    );
  }

  factory AppError.serverError() {
    return const AppError(
      messageKey: 'errors.server_error',
      type: ErrorType.internalServer,
      code: ErrorCode.internalServer,
    );
  }

  factory AppError.unknown([final String? technicalMessage]) {
    return AppError(
      messageKey: 'errors.unknown',
      type: ErrorType.unknown,
      code: ErrorCode.unknown,
      technicalMessage: technicalMessage,
    );
  }

  // Get User-Facing Message
  /// Returns the message to show to the user
  /// Priority: serverMessage > translated messageKey
  String getUserMessage() {
    // If server provided a message, use it (it's already user-friendly)
    if (serverMessage != null && serverMessage!.isNotEmpty) {
      return serverMessage!;
    }

    // Otherwise use the translated message key
    return messageKey.tr();
  }

  /// Get technical message for logging
  String getTechnicalMessage() {
    return technicalMessage ?? serverMessage ?? messageKey.tr();
  }

  // Utility Methods
  /// Check if this is a network-related error
  bool get isNetworkError =>
      type == ErrorType.noInternet ||
      type == ErrorType.timeout ||
      type == ErrorType.connectionError;

  /// Check if this is an authentication error
  bool get isAuthError =>
      type == ErrorType.unauthorized || type == ErrorType.forbidden;

  /// Check if user should retry
  bool get shouldRetry =>
      isNetworkError || type == ErrorType.timeout || code == 503;

  AppError copyWith({
    final String? messageKey,
    final String? serverMessage,
    final ErrorType? type,
    final int? code,
    final String? technicalMessage,
    final ErrorDetails? details,
    final dynamic originalError,
  }) {
    return AppError(
      messageKey: messageKey ?? this.messageKey,
      serverMessage: serverMessage ?? this.serverMessage,
      type: type ?? this.type,
      code: code ?? this.code,
      technicalMessage: technicalMessage ?? this.technicalMessage,
      details: details ?? this.details,
      originalError: originalError ?? this.originalError,
    );
  }

  @override
  String toString() {
    return 'AppError(type: $type, code: $code, message: ${getUserMessage()})';
  }

  /// For logging purposes
  Map<String, dynamic> toJson() {
    return {
      'messageKey': messageKey,
      'serverMessage': serverMessage,
      'type': type.toString(),
      'code': code,
      'technicalMessage': technicalMessage,
      'details': details?.toJson(),
    };
  }
}
