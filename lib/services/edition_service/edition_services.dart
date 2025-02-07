import 'package:injectable/injectable.dart';
import 'package:medito/services/edition_service/edition_repository.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_response.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';

@injectable
class EditionServices {
  final IEditionRepository _repository;

  EditionServices(this._repository);

  Future<EditionSearchResponse> editionSearch({ required EditionSearchRequest request }) => _repository.editionSearch(request: request);
  Future<FetchEditionResponse> getEdition({ required int editionId }) => _repository.getEdition(editionId: editionId);
}