import 'package:medito/services/edition_service/models/response/edition_search_response.dart';

class FetchEditionResponse {
  String? message;
  EditionResponse? data;

  FetchEditionResponse({
    this.message,
    this.data,
  });

  factory FetchEditionResponse.fromJson(Map<String, dynamic> json) => FetchEditionResponse(
    message: json['message'],
    data: json['data'] == null ? null : EditionResponse.fromJson(json['data']),
  );
}
