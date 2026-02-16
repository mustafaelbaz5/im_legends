import '../handlers/supabase_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_error.dart';

/// Central error handler for the application
class ErrorHandler {
  /// Handle any error and convert it to AppError
  ///
  /// This method ALWAYS throws an AppError, never returns
  static Never handle(final dynamic error) {
    // Already an AppError? Throw it as-is
    if (error is AppError) {
      throw error;
    }

    // // Dio exception? Convert it
    // if (error is DioException) {
    //   throw DioErrorHandler.handle(error);
    // }

    // Supabase exceptions?
    if (error is AuthException ||
        error is PostgrestException ||
        error is StorageException) {
      throw SupabaseErrorHandler.handle(error);
    }

    // Generic exception? Wrap it
    if (error is Exception) {
      throw AppError.unknown(error.toString());
    }

    // Unknown error type? Wrap it
    throw AppError.unknown(error?.toString() ?? 'Unknown error occurred');
  }

  /// Handle error without throwing (for logging or silent failures)
  static AppError handleSilent(final dynamic error) {
    if (error is AppError) return error;
    // if (error is DioException) return DioErrorHandler.handle(error);
    if (error is Exception) return AppError.unknown(error.toString());
    return AppError.unknown(error?.toString() ?? 'Unknown error occurred');
  }
}
