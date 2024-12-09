import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/models/explore/explore_list_item.dart';
import 'package:medito/providers/explore/track_search_provider.dart';
import 'package:medito/routes/routes.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_list.dart';
import 'package:medito/views/explore/widgets/explore_result_list/explore_result_list.dart';
import 'package:medito/views/explore/widgets/explore_text_field.dart';
import 'package:medito/views/home/widgets/header/home_header_widget.dart';
import 'package:medito/views/settings/settings_screen.dart';
import 'package:medito/widgets/track_card_widget.dart';
import 'package:medito/widgets/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreItem {
  final String title;
  final String duration;
  final String description;
  final String image;
  final String createdAt;
  final ExploreCategory category;

  ExploreItem({
    required this.title,
    required this.duration,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.category,
  });
}

class ExploreView extends ConsumerStatefulWidget {
  final FocusNode searchFocusNode;

  const ExploreView({super.key, required this.searchFocusNode});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounce;
  ExploreCategory? selectedCategory;

  final list = <ExploreItem>[
    ExploreItem(
      title: 'Is Love a concept?',
      duration: '10 min',
      description: 'Or the game of picking a definition and making a cry for it.',
      image: 'assets/images/explore/explore_image_1.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.edition,
    ),
    ExploreItem(
      title: 'If I am alone on an island how do I know Love exists?',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_2.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.article,
    ),
    ExploreItem(
      title: 'Could you be Love.',
      duration: '30 min',
      description: '',
      image: 'assets/images/explore/explore_image_3.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.podcast,
    ),
    ExploreItem(
      title: 'An energy without words.',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_4.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.sweetGym,
    ),
    ExploreItem(
      title: 'Flat tire',
      duration: '10 min',
      description: 'The subtle art of differentiating what happens vs what you make of it.',
      image: 'assets/images/explore/explore_image_5.jpeg',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.edition,
    ),
    ExploreItem(
      title: 'Hard Fact VS Point of View.',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_6.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.article,
    ),
    ExploreItem(
      title: "It's just emotions taking me over.",
      duration: '30 min',
      description: '',
      image: 'assets/images/explore/explore_image_7.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.podcast,
    ),
    ExploreItem(
      title: 'The fact checker.',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_8.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.sweetGym,
    ),

    ExploreItem(
      title: 'What did you just say?',
      duration: '10 min',
      description: 'Or comments felt as flying knives.',
      image: 'assets/images/explore/explore_image_9.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.edition,
    ),
    ExploreItem(
      title: "What is it really that gets hurt by another's point of view?",
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_10.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.article,
    ),
    ExploreItem(
      title: "Shut up while I'm talking to you.",
      duration: '30 min',
      description: '',
      image: 'assets/images/explore/explore_image_11.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.podcast,
    ),
    ExploreItem(
      title: 'Becoming the sound.',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_12.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.sweetGym,
    ),

    ExploreItem(
      title: 'The purpose promise.',
      duration: '10 min',
      description: 'Or comments felt as flying knives.',
      image: 'assets/images/explore/explore_image_13.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.edition,
    ),
    ExploreItem(
      title: 'When did the need for a purpose appear?',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_14.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.article,
    ),
    ExploreItem(
      title: 'Controversial. Dictators also have a purpose.',
      duration: '30 min',
      description: '',
      image: 'assets/images/explore/explore_image_15.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.podcast,
    ),
    ExploreItem(
      title: 'Passion as guide.',
      duration: '10 min',
      description: '',
      image: 'assets/images/explore/explore_image_16.png',
      createdAt: '10 Jun 2024',
      category: ExploreCategory.sweetGym,
    ),
  ];

  List<ExploreItem> get items => list.where((l) => l.category == (selectedCategory ?? l.category)).toList();

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void unfocusSearch() {
    widget.searchFocusNode.unfocus();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = value;
      });
    });
  }

  Future<void> _refreshExploreList() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: RefreshIndicator(
        edgeOffset: 150,
        onRefresh: _refreshExploreList,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 36, left: 24, right: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Browse',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          FadePageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'DN',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 32),
                    const ExploreTextField(),
                    const SizedBox(height: 32),
                    ExploreCategoryList(
                      selected: selectedCategory,
                      onCategorySelect: (c) {
                        setState(() {
                          selectedCategory = selectedCategory != c ? c : null;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    ExploreResultList(items: items),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreContentWidget extends ConsumerWidget {
  final String searchQuery;
  final VoidCallback onPackTapped;

  const ExploreContentWidget({
    super.key,
    required this.searchQuery,
    required this.onPackTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var exploreItems = ref.watch(exploreListProvider(searchQuery));

    return exploreItems.when(
      data: (data) => _buildContent(context, ref, data),
      error: (err, stack) => MeditoErrorWidget(
        isScaffold: false,
        message: err.toString(),
        onTap: () => ref.invalidate(exploreListProvider(searchQuery)),
      ),
      loading: () => const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.white),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, WidgetRef ref, List<ExploreListItem> items) {
    var packItems = items.whereType<PackItem>().toList();
    var trackItems = items.whereType<TrackItem>().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (packItems.isNotEmpty) _buildPackList(context, ref, packItems),
        if (trackItems.isNotEmpty) _buildExploreList(context, ref, trackItems),
      ],
    );
  }

  Widget _buildPackList(
      BuildContext context, WidgetRef ref, List<PackItem> packItems) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        var itemWidth =
            (constraints.maxWidth - (crossAxisCount + 1) * padding16) /
                crossAxisCount;

        return MasonryGridView.count(
          padding: const EdgeInsets.only(
            left: padding16,
            right: padding16,
            top: padding16,
          ),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: padding16,
          crossAxisSpacing: padding16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: packItems.length,
          itemBuilder: (context, index) {
            var item = packItems[index];

            return SizedBox(
              width: itemWidth,
              child: PackCardWidget(
                title: item.title,
                subTitle: item.subtitle,
                coverUrlPath: item.coverUrl,
                onTap: () {
                  onPackTapped();
                  handleNavigation(
                    TypeConstants.theme,
                    [item.id],
                    context,
                    ref: ref,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildExploreList(
      BuildContext context, WidgetRef ref, List<ExploreListItem> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen =
            MediaQuery.of(context).orientation == Orientation.landscape ||
                MediaQuery.of(context).size.shortestSide >= 600;

        return isWideScreen
            ? _buildGridView(context, items, ref, constraints)
            : _buildListView(context, items, ref);
      },
    );
  }

  Widget _buildListView(
      BuildContext context, List<ExploreListItem> items, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(padding16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        var item = items[index];
        return TrackCardWidget(
          title: item.title,
          subTitle: item.subtitle,
          coverUrlPath: item.coverUrl,
          onTap: () {
            onPackTapped();
            handleNavigation(
              TypeConstants.theme,
              [item.id],
              context,
              ref: ref,
            );
          },
        );
      },
    );
  }

  Widget _buildGridView(BuildContext context, List<ExploreListItem> items,
      WidgetRef ref, BoxConstraints constraints) {
    var itemWidth = (constraints.maxWidth - padding16) / 2;

    return Wrap(
      spacing: 0,
      runSpacing: padding16,
      children: items.map((item) {
        return SizedBox(
          width: itemWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: padding16),
            child: TrackCardWidget(
              title: item.title,
              subTitle: item.subtitle,
              coverUrlPath: item.coverUrl,
              onTap: () {
                onPackTapped();
                handleNavigation(
                  TypeConstants.theme,
                  [item.id],
                  context,
                  ref: ref,
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBox({
    super.key,
    required this.onChanged,
    required this.onClear,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: StringConstants.searchMeditations,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        ),
        filled: true,
        fillColor: ColorConstants.white.withOpacity(0.1),
      ),
      style: const TextStyle(color: ColorConstants.white),
      onChanged: onChanged,
    );
  }
}
