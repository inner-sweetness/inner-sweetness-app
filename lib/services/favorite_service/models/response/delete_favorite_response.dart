class DeleteFavoriteResponse {
  String? message;

  DeleteFavoriteResponse({
    this.message,
  });

  factory DeleteFavoriteResponse.fromJson(Map<String, dynamic> json) => DeleteFavoriteResponse(
    message: json["message"],
  );
}