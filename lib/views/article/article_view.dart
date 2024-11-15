import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/models/article/article_model.dart';
import 'package:medito/providers/article/article_provider.dart';
import 'package:medito/views/player/widgets/bottom_actions/single_back_action_bar.dart';
import 'package:medito/widgets/errors/medito_error_widget.dart';
import 'package:medito/widgets/headers/description_widget.dart';
import 'package:medito/widgets/headers/medito_app_bar_large.dart';
import 'package:medito/widgets/shimmers/folder_shimmer_widget.dart';

class ArticleView extends ConsumerStatefulWidget {
  const ArticleView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView>
    with AutomaticKeepAliveClientMixin<ArticleView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var packs = ref.watch(articleProvider(articleId: widget.id));

    return Scaffold(
      bottomNavigationBar: SingleBackButtonActionBar(onBackPressed: () {
        Navigator.pop(context);
      }),
      body: packs.when(
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        data: (data) => _buildScaffoldWithData(data, ref),
        error: (err, stack) => MeditoErrorWidget(
          message: err.toString(),
          onTap: () => ref.refresh(articleProvider(articleId: widget.id)),
          isLoading: packs.isLoading,
        ),
        loading: () => const FolderShimmerWidget(),
      ),
    );
  }

  void _scrollListener() {
    setState(() => {});
  }

  RefreshIndicator _buildScaffoldWithData(
      ArticleModel article,
      WidgetRef ref,
      ) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(articleProvider(articleId: widget.id)),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          MeditoAppBarLarge(
            scrollController: _scrollController,
            title: article.title,
            subTitle: article.subTitle,
            hasLeading: false,
            coverUrl: article.coverUrl,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              DescriptionWidget(description: article.description),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}