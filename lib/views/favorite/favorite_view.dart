import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/favorite/favorite_content.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchFavoritesBloc>(
      create: (context) => getIt<FetchFavoritesBloc>()..add(const FetchFavorites()),
      child: const FavoriteContent(),
    );
  }
}
