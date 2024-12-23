import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/favorite_service/models/response/fetch_favorite_response.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';
import 'package:medito/views/favorite/widgets/favorite_list/favorite_item.dart';


class FavoriteList extends StatelessWidget {
  final List<FavoriteResponse> items;
  const FavoriteList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: () async => context.read<FetchFavoritesBloc>().add(const FetchFavorites()),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items
              .where((i) => i.edition != null)
              .map((i) => FavoriteItem(item: i.edition!))
              .toList(),
        ),
      ),
    );
  }
}
