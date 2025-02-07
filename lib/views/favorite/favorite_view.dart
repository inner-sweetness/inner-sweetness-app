import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/views/favorite/favorite_content.dart';
import 'package:medito/views/favorite/logic/cubit/filter_favorite_cubit/filter_favorite_cubit.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterFavoriteCubit(),
      child: const FavoriteContent(),
    );
  }
}
