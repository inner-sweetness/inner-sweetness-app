import 'package:flutter/material.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_item.dart';

enum ExploreCategory { edition, article, podcast, sweetGym }

extension ExploreCategoryExtension on ExploreCategory {
  String get label {
    switch(this) {
      case ExploreCategory.edition:
        return 'Edition';
      case ExploreCategory.article:
        return 'Article';
      case ExploreCategory.podcast:
        return 'Podcast';
      case ExploreCategory.sweetGym:
        return 'Sweet Gym';
    }
  }

  Color get color {
    switch(this) {
      case ExploreCategory.edition:
        return const Color(0xFFFF9900);
      case ExploreCategory.article:
        return const Color(0xFF0150FF);
      case ExploreCategory.podcast:
        return const Color(0xFFFFF500);
      case ExploreCategory.sweetGym:
        return const Color(0xFF03F480);
    }
  }
}

class ExploreCategoryList extends StatelessWidget {
  final ExploreCategory? selected;
  final Function(ExploreCategory) onCategorySelect;
  const ExploreCategoryList({super.key, this.selected, required this.onCategorySelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: ExploreCategory.values.map((c) => ExploreCategoryItem(
          selected: selected == c,
          onTap: () => onCategorySelect(c),
          color: c.color,
          text: c.label,
        )).toList(),
      ),
    );
  }
}
