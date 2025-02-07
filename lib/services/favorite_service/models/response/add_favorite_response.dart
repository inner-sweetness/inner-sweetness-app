class AddFavoriteResponse {
  int? id;
  String? createdAt;
  int? editionId;

  AddFavoriteResponse({
    this.id,
    this.createdAt,
    this.editionId,
  });

  factory AddFavoriteResponse.fromJson(Map<String, dynamic> json) => AddFavoriteResponse(
    id: json['id'],
    createdAt: json['createdAt'],
    editionId: json['editionId'],
  );
}