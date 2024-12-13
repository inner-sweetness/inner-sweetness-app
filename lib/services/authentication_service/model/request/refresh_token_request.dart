class RefreshTokenRequest {
  String refreshToken;

  RefreshTokenRequest({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
  };
}
