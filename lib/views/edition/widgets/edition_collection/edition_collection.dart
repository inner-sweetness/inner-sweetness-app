import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_child_cubit/set_favorite_child_cubit.dart';
import 'package:medito/views/edition/widgets/edition_collection/edition_item.dart';

class EditionCollection extends StatelessWidget {
  final List<EditionResponse> items;
  const EditionCollection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(children: items.map((i) => BlocProvider(
      create: (context) => SetFavoriteChildCubit(i.isFavorite),
      child: EditionItem(edition: i),
    )).toList());
  }
}
