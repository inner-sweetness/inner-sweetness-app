import 'package:medito/models/article/article_model.dart';
import 'package:medito/repositories/article/articles_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_provider.g.dart';

@riverpod
class Article extends _$Article {
  @override
  AsyncValue<ArticleModel> build({required String articleId}) {
    fetchArticles(articleId: articleId);

    return const AsyncLoading();
  }

  Future<void> fetchArticles({required String articleId}) async {
    final articleRepository = ref.read(articleRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await articleRepository.fetchArticles(articleId);
    });

    ref.keepAlive();
  }
}
