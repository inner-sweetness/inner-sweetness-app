import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/article/article_view.dart';
import 'package:medito/views/audio/audio_view.dart';
import 'package:medito/views/edition/edition_view.dart';
import 'package:medito/views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_child_cubit/set_favorite_child_cubit.dart';

class EditionItem extends StatelessWidget {
  final EditionResponse edition;
  const EditionItem({super.key, required this.edition});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetFavoriteChildCubit, bool>(
      listener: (context, bool isFavoriteState) {
        final editionId = edition.id;
        if (editionId == null) return;
        if (isFavoriteState) {
          context.read<AddFavoriteBloc>().add(AddFavorite(editionId: editionId));
        } else {
          context.read<DeleteFavoriteBloc>().add(DeleteFavorite(editionId: editionId));
        }
      },
      child: GestureDetector(
        onTap: () async {
          final category = edition.category;
          if (category == null) return;
          final editionId = edition.id;
          if (editionId == null) return;
          edition.isFavorite = context.read<SetFavoriteChildCubit>().state;
          await Navigator.of(context).push(
            FadePageRoute(
              builder: (context) {
                switch(category) {
                  case EditionSearchCategory.mainEdition:
                    return EditionView(editionId: editionId);
                  case EditionSearchCategory.article:
                    return ArticleView(edition: edition);
                  case EditionSearchCategory.podcast:
                    return AudioView(edition: edition);
                  case EditionSearchCategory.sweetGym:
                    return AudioView(edition: edition);
                }
              },
            ),
          );
          if (edition.isFavorite != context.read<SetFavoriteChildCubit>().state) {
            context.read<SetFavoriteChildCubit>().change(edition.isFavorite);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF6A6C6A),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  edition.coverUrl ?? '',
                  height: 36,
                  width: 36,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            edition.title ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BlocBuilder<SetFavoriteChildCubit, bool>(
                              builder: (context, bool isFavoriteState) => GestureDetector(
                                onTap: () => context.read<SetFavoriteChildCubit>().change(!isFavoriteState),
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  isFavoriteState ? Icons.favorite : Icons.favorite_border_outlined,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            edition.category == EditionSearchCategory.article ? const Icon(
                              Icons.menu_book_outlined,
                              size: 24,
                              color: Colors.white,
                            ) : const Icon(
                              Icons.play_circle,
                              size: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          edition.category?.label ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFADADAD),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          edition.duration ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFADADAD),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    if (edition.description?.isNotEmpty ?? false)
                      ...[
                        const SizedBox(height: 8),
                        Text(
                          edition.description ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFADADAD),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
