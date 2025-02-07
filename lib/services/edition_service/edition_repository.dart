import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_response.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';

abstract class IEditionRepository {
  Future<EditionSearchResponse> editionSearch({ required EditionSearchRequest request });
  Future<FetchEditionResponse> getEdition({ required int editionId });
}

@LazySingleton(as: IEditionRepository)
class EditionRepository implements IEditionRepository {
  final DioClient _dioClient;

  EditionRepository(this._dioClient);

  @override
  Future<EditionSearchResponse> editionSearch({ required EditionSearchRequest request }) async {
    var response = await _dioClient.post(
      '${HTTPConstants.baseUrl}/editions/search',
      body: request.toJson(),
    );
    return EditionSearchResponse.fromJson((response.data as Map<String, Object?>));
  }

  @override
  Future<FetchEditionResponse> getEdition({ required int editionId }) async {
    var response = await _dioClient.get('${HTTPConstants.baseUrl}/editions/$editionId');
    return FetchEditionResponse.fromJson((response.data as Map<String, Object?>));
  }
}