import 'package:medito/services/edition_service/models/response/edition_search_response.dart';

class FetchFavoriteResponse {
  String? message;
  List<FavoriteResponse> data;

  FetchFavoriteResponse({
    this.message,
    this.data = const <FavoriteResponse>[],
  });

  factory FetchFavoriteResponse.fromJson(Map<String, dynamic> json) => FetchFavoriteResponse(
    message: json["message"],
    data: json["data"] == null ? [] : List<FavoriteResponse>.from(json["data"]!.map((x) => FavoriteResponse.fromJson(x))),
  );
}

class FavoriteResponse {
  int? id;
  String? createdAt;
  EditionResponse? edition;

  FavoriteResponse({
    this.id,
    this.createdAt,
    this.edition,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => FavoriteResponse(
    id: json["id"],
    createdAt: json["createdAt"],
    edition: json["edition"] == null ? null : EditionResponse.fromJson(json["edition"]),
  );
}