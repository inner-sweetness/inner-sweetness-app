class ResetPasswordResponse {
  int? statusCode;
  String? message;

  ResetPasswordResponse({
    required this.statusCode,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    statusCode: json['statusCode'],
    message: json['message'],
  );
}
