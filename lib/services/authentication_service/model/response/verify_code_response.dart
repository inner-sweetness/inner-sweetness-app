class VerifyCodeResponse {
  int? statusCode;
  String? message;

  VerifyCodeResponse({
    required this.statusCode,
    required this.message,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) => VerifyCodeResponse(
    statusCode: json['statusCode'],
    message: json['message'],
  );
}
