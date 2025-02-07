import 'package:flutter/material.dart';
import 'package:medito/services/favorite_service/models/response/fetch_favorite_response.dart';
import 'package:medito/views/favorite/widgets/favorite_list/favorite_item.dart';


class FavoriteList extends StatelessWidget {
  final List<FavoriteResponse> items;
  const FavoriteList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items
            .where((i) => i.edition != null)
            .map((i) => FavoriteItem(edition: i.edition!))
            .toList(),
      ),
    );
  }
}
