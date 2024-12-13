class RefreshTokenResponse {
  String accessToken;

  RefreshTokenResponse({
    required this.accessToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => RefreshTokenResponse(
    accessToken: json["accessToken"],
  );
}
