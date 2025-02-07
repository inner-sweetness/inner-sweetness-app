class ResetPasswordRequest {
  String code;
  String newPassword;
  String email;

  ResetPasswordRequest({
    required this.code,
    required this.newPassword,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "code": code,
    "newPassword": newPassword,
    "email": email,
  };
}
