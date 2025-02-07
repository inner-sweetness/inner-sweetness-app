import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/contentful_service/models/response/contentful_app_response.dart';
import 'package:medito/services/contentful_service/models/response/contentful_network_response.dart';

abstract class IContentfulRepository {
  Future<ContentfulNetworksResponse> fetchNetworks();
  Future<ContentfulAppResponse> fetchApp();
}

@LazySingleton(as: IContentfulRepository)
class ContentfulRepository implements IContentfulRepository {
  final DioClient _dioClient;

  ContentfulRepository(this._dioClient);

  @override
  Future<ContentfulNetworksResponse> fetchNetworks() async {
    var response = await _dioClient.get('${HTTPConstants.baseUrl}/contentful/networks');
    return ContentfulNetworksResponse.fromJson(response.data as Map<String, Object?>);
  }

  @override
  Future<ContentfulAppResponse> fetchApp() async {
    var response = await _dioClient.get('${HTTPConstants.baseUrl}/contentful/app');
    return ContentfulAppResponse.fromJson(response.data as Map<String, Object?>);
  }
  
}