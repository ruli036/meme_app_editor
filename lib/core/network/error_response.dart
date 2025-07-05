class ErrorResponse {
  String? message;

  ErrorResponse({
    this.message,
  });
  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

class ApiErrorResponse {
  final bool status;
  final String message;
  final ErrorData? data;

  ApiErrorResponse({
    required this.status,
    required this.message,
    this.data,
  });

  // Create a factory constructor for JSON deserialization
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? ErrorData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ErrorData {
  final String error;
  final String errorDescription;

  ErrorData({
    required this.error,
    required this.errorDescription,
  });

  // Create a factory constructor for JSON deserialization
  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
      error: json['error'] as String,
      errorDescription: json['error_description'] as String,
    );
  }
}