class ErrorDetails {
  final Map<String, dynamic> metadata;

  const ErrorDetails({required this.metadata});

  factory ErrorDetails.fromJson(final Map<String, dynamic> json) {
    return ErrorDetails(metadata: json);
  }

  Map<String, dynamic> toJson() => metadata;

  /// Get validation errors if available
  List<String>? get validationErrors {
    if (metadata['errors'] is List) {
      return (metadata['errors'] as List)
          .map((final e) => e.toString())
          .toList();
    }
    return null;
  }

  /// Get field-specific errors
  Map<String, dynamic>? get fieldErrors {
    if (metadata['field_errors'] is Map) {
      return metadata['field_errors'] as Map<String, dynamic>;
    }
    return null;
  }

  /// Get trace ID for debugging
  String? get traceId => metadata['trace_id']?.toString();

  @override
  String toString() => 'ErrorDetails(metadata: $metadata)';
}
