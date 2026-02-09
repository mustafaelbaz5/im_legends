enum ErrorType {
  /// Network/Internet related
  noInternet,
  timeout,
  connectionError,

  /// HTTP Client errors (4xx)
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  validation,
  tooManyRequests,

  /// HTTP Server errors (5xx)
  internalServer,
  serviceUnavailable,

  /// Operation errors
  cancel,

  /// Unknown/Unexpected
  unknown,
}

/// Standard error codes
class ErrorCode {
  // Network errors (using custom codes)
  static const int noInternet = -1001;
  static const int timeout = -1002;
  static const int cancel = -1003;

  // HTTP standard status codes
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int tooManyRequests = 429;
  static const int internalServer = 500;
  static const int serviceUnavailable = 503;

  // Unknown
  static const int unknown = -9999;
}
