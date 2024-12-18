import 'package:injectable/injectable.dart';
import 'package:medito/services/contentful_services/contentful_repository.dart';
import 'package:medito/services/contentful_services/models/response/contentful_app_response.dart';
import 'package:medito/services/contentful_services/models/response/contentful_network_response.dart';

@injectable
class ContentfulServices {
  final IContentfulRepository _repository;

  ContentfulServices(this._repository);

  Future<ContentfulNetworksResponse> fetchNetworks() => _repository.fetchNetworks();
  Future<ContentfulAppResponse> fetchApp() => _repository.fetchApp();
}