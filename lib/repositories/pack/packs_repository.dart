import 'package:medito/constants/constants.dart';
import 'package:medito/models/models.dart';
import 'package:medito/services/network/dio_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'packs_repository.g.dart';

abstract class PacksRepository {
  Future<List<PackItemsModel>> fetchAllPacks();

  Future<PackModel> fetchPacks(String packId);
}

class PackRepositoryImpl extends PacksRepository {
  final DioApiService client;

  PackRepositoryImpl({required this.client});

  @override
  Future<List<PackItemsModel>> fetchAllPacks() async {
    var response = await client.getRequest(HTTPConstants.packs);
    var tempResponse = response as List;

    return tempResponse.map((x) => PackItemsModel.fromJson(x)).toList();
  }

  @override
  Future<PackModel> fetchPacks(String packId) async {
    return const PackModel(
      id: 'pack-model-1',
      title: 'The Tema',
      subTitle: 'The Tema Sub Title',
      description: '',
      coverUrl: '',
      isPublished: false,
      items: <PackItemsModel>[
        PackItemsModel(
          id: 'article_1',
          type: TypeConstants.article,
          title: 'Artículo',
          subtitle: 'Sub Título',
          path: 'article_1',
        ),
        PackItemsModel(
          id: 'track_1',
          type: TypeConstants.track,
          title: 'Podcast',
          subtitle: 'Could you be Love',
          path: 'track_1',
        ),
        PackItemsModel(
          id: 'track_2',
          type: TypeConstants.track,
          title: 'Sweet Challenge',
          subtitle: 'An energy without words.',
          path: 'track_2',
        ),
      ],
    );
    // var response = await client.getRequest('${HTTPConstants.packs}/$packId');
    // return PackModel.fromJson(response);
  }
}

@Riverpod(keepAlive: true)
PackRepositoryImpl packRepository(PackRepositoryRef _) {
  return PackRepositoryImpl(client: DioApiService());
}
