import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/fetch_edition_bloc/fetch_edition_bloc.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_cubit/set_favorite_cubit.dart';

class AudioContent extends StatefulWidget {
  const AudioContent({super.key});

  @override
  State<AudioContent> createState() => _AudioContentState();
}

class _AudioContentState extends State<AudioContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchEditionBloc, FetchEditionState>(
      builder: (context, state) {
        if (state is FetchEditionLoadingState) {
          return const Center(
            child: SizedBox(
              height: 64,
              width: 64,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is FetchEditionSuccessState) {
          final edition = state.edition;
          context.read<SetFavoriteCubit>().change(edition.isFavorite);
          return BlocListener<SetFavoriteCubit, bool>(
            listener: (context, bool isFavoriteState) {
              final editionId = edition.id;
              if (editionId == null) return;
              if (isFavoriteState) {
                context.read<AddFavoriteBloc>().add(AddFavorite(editionId: editionId));
              } else {
                context.read<DeleteFavoriteBloc>().add(DeleteFavorite(editionId: editionId));
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xFF1E1E1E),
              body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      onTap: Navigator.of(context).maybePop,
                      behavior: HitTestBehavior.opaque,
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.network(
                      edition.coverUrl ?? '',
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    edition.title ?? '',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                BlocBuilder<SetFavoriteCubit, bool>(
                                  builder: (context, bool isFavoriteState) => GestureDetector(
                                    onTap: () => context.read<SetFavoriteCubit>().change(!isFavoriteState),
                                    behavior: HitTestBehavior.opaque,
                                    child: isFavoriteState ? const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 24,
                                    ) : const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: edition.category?.color,
                                ),
                                child: Text(
                                  edition.category?.label ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  edition.duration ?? '',
                                  style: const TextStyle(
                                    color: Color(0xFFADADAD),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd EEE yyyy').format(edition.createdAtDate),
                                  style: const TextStyle(
                                    color: Color(0xFFADADAD),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                height: 2,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: edition.category?.color,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
