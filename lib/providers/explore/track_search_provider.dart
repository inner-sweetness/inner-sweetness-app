import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/types/type_constants.dart';
import 'package:medito/models/explore/explore_list_item.dart';
import 'package:medito/models/home/home_model.dart';
import 'package:medito/models/home/shortcuts/shortcuts_model.dart';
import 'package:medito/repositories/explore/track_search_repository.dart';
import 'package:medito/services/network/dio_api_service.dart';

final trackSearchRepositoryProvider = Provider<TrackSearchRepository>((ref) {
  return TrackSearchRepository(DioApiService());
});

final searchTracksProvider =
    FutureProvider.family<List<ExploreListItem>, String>(
  (ref, query) async {
    //final repository = ref.watch(trackSearchRepositoryProvider);
    // final tracks = await repository.searchTracks(query);
    final themes = <HomeModel>[
      HomeModel(
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
      ),
    ];
    return themes
        .map((theme) => ExploreListItem.pack(
      id: theme.id,
      title: theme.title ?? '',
      subtitle: theme.subTitle ?? '',
      coverUrl: theme.coverUrl ?? '',
    ))
        .toList();
  },
);

final exploreListProvider =
    FutureProvider.family<List<ExploreListItem>, String>(
  (ref, query) async {
    if (query.isEmpty) {
      // final packs = await ref.watch(fetchAllPacksProvider.future);
      return [];
    } else {
      return ref.watch(searchTracksProvider(query).future);
    }
  },
);
