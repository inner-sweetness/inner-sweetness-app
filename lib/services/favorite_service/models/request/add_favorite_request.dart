class AddFavoriteRequest {
  int? editionId;

  AddFavoriteRequest({
    this.editionId,
  });

  Map<String, dynamic> toJson() => {
    "editionId": editionId,
  };
}