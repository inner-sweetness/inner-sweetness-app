class SendCodeResponse {
  String? message;

  SendCodeResponse({
    required this.message,
  });

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) => SendCodeResponse(
    message: json['message'],
  );
}
