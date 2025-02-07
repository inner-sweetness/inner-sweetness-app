import 'package:flutter/material.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_item.dart';

class ExploreCategoryList extends StatelessWidget {
  final EditionSearchCategory? selected;
  final Function(EditionSearchCategory) onCategorySelect;
  const ExploreCategoryList({super.key, this.selected, required this.onCategorySelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: EditionSearchCategory.values.map((c) => ExploreCategoryItem(
          selected: selected == c,
          onTap: () => onCategorySelect(c),
          color: c.color,
          text: c.label,
        )).toList(),
      ),
    );
  }
}
