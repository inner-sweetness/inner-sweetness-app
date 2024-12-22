import 'package:injectable/injectable.dart';
import 'package:medito/services/favorite_service/favorite_repository.dart';
import 'package:medito/services/favorite_service/models/request/add_favorite_request.dart';
import 'package:medito/services/favorite_service/models/response/add_favorite_response.dart';
import 'package:medito/services/favorite_service/models/response/delete_favorite_response.dart';
import 'package:medito/services/favorite_service/models/response/fetch_favorite_response.dart';

@injectable
class FavoriteServices {
  final IFavoriteRepository _repository;

  FavoriteServices(this._repository);

  Future<AddFavoriteResponse> addFavorite({ required AddFavoriteRequest request }) => _repository.addFavorite(request: request);
  Future<DeleteFavoriteResponse> deleteFavorite({ required int editionId }) => _repository.deleteFavorite(editionId: editionId);
  Future<FetchFavoriteResponse> fetchFavorites() => _repository.fetchFavorites();
}