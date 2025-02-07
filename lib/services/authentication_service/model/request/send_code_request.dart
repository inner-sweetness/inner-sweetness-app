class SendCodeRequest {
  String email;

  SendCodeRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
