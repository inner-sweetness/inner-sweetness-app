import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/favorite_service/models/request/add_favorite_request.dart';
import 'package:medito/services/favorite_service/models/response/add_favorite_response.dart';
import 'package:medito/services/favorite_service/models/response/delete_favorite_response.dart';
import 'package:medito/services/favorite_service/models/response/fetch_favorite_response.dart';

abstract class IFavoriteRepository {
  Future<AddFavoriteResponse> addFavorite({ required AddFavoriteRequest request });
  Future<DeleteFavoriteResponse> deleteFavorite({ required int editionId });
  Future<FetchFavoriteResponse> fetchFavorites();
}

@LazySingleton(as: IFavoriteRepository)
class FavoriteRepository implements IFavoriteRepository {
  final DioClient _dioClient;

  FavoriteRepository(this._dioClient);

  @override
  Future<AddFavoriteResponse> addFavorite({ required AddFavoriteRequest request }) async {
    final response = await _dioClient.post('${HTTPConstants.baseUrl}/favorites', body: request.toJson());
    return AddFavoriteResponse.fromJson((response.data as Map<String, Object?>));
  }

  @override
  Future<DeleteFavoriteResponse> deleteFavorite({ required int editionId }) async {
    final response = await _dioClient.delete('${HTTPConstants.baseUrl}/favorites/$editionId');
    return DeleteFavoriteResponse.fromJson((response.data as Map<String, Object?>));
  }

  @override
  Future<FetchFavoriteResponse> fetchFavorites() async {
    final response = await _dioClient.get('${HTTPConstants.baseUrl}/favorites');
    return FetchFavoriteResponse.fromJson((response.data as Map<String, Object?>));
  }
}