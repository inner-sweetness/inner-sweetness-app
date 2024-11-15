import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/models/models.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/services/network/dio_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

abstract class HomeRepository {
  Future<HomeModel> fetchHome();

  List<String> getLocalShortcutIds();

  Future<AnnouncementModel?> fetchLatestAnnouncement();

  Future<void> setShortcutIdsInPreference(
    List<String> ids,
  );
}

class HomeRepositoryImpl extends HomeRepository {
  final DioApiService client;
  final Ref ref;

  HomeRepositoryImpl({required this.ref, required this.client});

  @override
  List<String> getLocalShortcutIds() {
    return ref
            .read(sharedPreferencesProvider)
            .getStringList(SharedPreferenceConstants.shortcuts) ??
        [];
  }

  @override
  Future<void> setShortcutIdsInPreference(List<String> ids) async {
    await ref
        .read(sharedPreferencesProvider)
        .setStringList(SharedPreferenceConstants.shortcuts, ids);
  }

  @override
  Future<HomeModel> fetchHome() async {
    return HomeModel(
      id: 'home_model_1',
      title: 'Tema',
      coverUrl: '',
      subTitle: 'Sub Titulo del Tema',
      shortcuts: List.generate(
        4,
        (index) => ShortcutsModel(
            id: '$index',
            type: 'TYPE ${index % 2}',
            title: 'Titulo $index',
            path: null,
            icon: null),
      ),
      carousel: const <HomeCarouselModel>[
        HomeCarouselModel(
          id: 'home-carouse-model-1',
          title: 'Artículo',
          subtitle: 'Sub Título',
          coverUrl: '',
          path: 'article_1',
          type: TypeConstants.article,
        ),
        HomeCarouselModel(
          id: 'home-carouse-model-2',
          title: 'Podcast',
          subtitle: 'Could you be Love',
          coverUrl: '',
          path: 'track_1',
          type: TypeConstants.track,
        ),
        HomeCarouselModel(
          id: 'home-carouse-model-3',
          title: 'Sweet Challenge',
          subtitle: 'An energy without words.',
          coverUrl: '',
          path: 'track_2',
          type: TypeConstants.track,
        ),
      ],
      todayQuote: const HomeQuoteModel(
          id: 'HomeQuote1',
          quote: 'Quote? Yes Quote!',
          author: 'Quote Author, unexpected...'),
    );
    // var response = await client.getRequest(HTTPConstants.home);
    // return HomeModel.fromJson(response);
  }

  @override
  Future<AnnouncementModel?> fetchLatestAnnouncement() async {
    var response = await client.getRequest(HTTPConstants.latestAnnouncement);

    return AnnouncementModel.fromJson(response);
  }

  Future<List<ShortcutsModel>> getSortedShortcuts(
      List<ShortcutsModel> shortcuts) async {
    var savedIds = getLocalShortcutIds();
    if (savedIds.isEmpty) return shortcuts;

    var sortedShortcuts = List<ShortcutsModel>.from(shortcuts);
    sortedShortcuts.sort((a, b) {
      var indexA = savedIds.indexOf(a.id ?? '');
      var indexB = savedIds.indexOf(b.id ?? '');
      if (indexA == -1) return 1;
      if (indexB == -1) return -1;

      return indexA.compareTo(indexB);
    });

    return sortedShortcuts;
  }
}

@riverpod
HomeRepositoryImpl homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(ref: ref, client: DioApiService());
}
