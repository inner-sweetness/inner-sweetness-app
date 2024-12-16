class VerifyCodeRequest {
  String code;
  String email;

  VerifyCodeRequest({
    required this.code,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "code": code,
    "email": email,
  };
}
