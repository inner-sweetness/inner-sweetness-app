import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medito/views/explore/explore_view.dart';
import 'package:medito/views/explore/widgets/explore_result_list/explore_result_card.dart';

class ExploreResultList extends StatelessWidget {
  final List<ExploreItem> items;
  const ExploreResultList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      children: items.map((i) => ExploreResultCard(item: i)).toList(),
    );
  }
}
