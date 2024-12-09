import 'package:flutter/material.dart';
import 'package:medito/views/explore/explore_view.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_list.dart';
import 'package:medito/views/favorite/widgets/favorite_list/favorite_item.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FavoriteItem(
            item: ExploreItem(
              title: 'Is Love a concept?',
              duration: '',
              description: 'Podcast - Is Love a concept?',
              image: 'assets/images/explore/explore_image_1.png',
              createdAt: '',
              category: ExploreCategory.edition,
            ),
          ),
          FavoriteItem(
            item: ExploreItem(
              title: 'An energy without words.',
              duration: '',
              description: 'Sweet Gym - Is Love a concept?',
              image: 'assets/images/explore/explore_image_4.png',
              createdAt: '',
              category: ExploreCategory.sweetGym,
            ),
          ),
          FavoriteItem(
            item: ExploreItem(
              title: 'Hard Fact VS Point of View.',
              duration: '',
              description: 'Article - Is Love a concept?',
              image: 'assets/images/explore/explore_image_8.png',
              createdAt: '',
              category: ExploreCategory.article,
            ),
          ),
          FavoriteItem(
            item: ExploreItem(
              title: 'Passion as guide.',
              duration: '',
              description: 'Sweet Gym - Is Love a concept?',
              image: 'assets/images/explore/explore_image_12.png',
              createdAt: '',
              category: ExploreCategory.sweetGym,
            ),
          ),
        ],
      ),
    );
  }
}
