import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/explore/widgets/explore_result_list/explore_result_card.dart';

class ExploreResultList extends StatelessWidget {
  final List<EditionResponse> items;
  final bool isLoading;
  const ExploreResultList({super.key, required this.items, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: items.map((i) => ExploreResultCard(item: i)).toList(),
          ),
          if (isLoading)
            const SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
