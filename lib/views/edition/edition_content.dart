import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medito/views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/fetch_edition_bloc/fetch_edition_bloc.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_cubit/set_favorite_cubit.dart';
import 'package:medito/views/edition/widgets/edition_collection/edition_collection.dart';

class EditionContent extends StatefulWidget {
  const EditionContent({super.key});

  @override
  State<EditionContent> createState() => _EditionContentState();
}

class _EditionContentState extends State<EditionContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchEditionBloc, FetchEditionState>(
      builder: (context, FetchEditionState state) {
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
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Material(
                      color: const Color(0xFFDFDFDF),
                      child: SizedBox(
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                edition.coverUrl ?? '',
                                height: 240,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Container(
                              height: 240,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: const [0, .78],
                                    colors: [
                                      const Color(0xFF1E1E1E),
                                      (const Color(0xFF1E1E1E)).withOpacity(0),
                                    ],
                                  )
                              ),
                            ),
                            SafeArea(
                              child: GestureDetector(
                                onTap: Navigator.of(context).maybePop,
                                behavior: HitTestBehavior.opaque,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    margin: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            edition.title ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                edition.duration ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFADADAD),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                DateFormat('dd EEE yyyy').format(edition.createdAtDate),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFADADAD),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              BlocBuilder<SetFavoriteCubit, bool>(
                                builder: (context, bool isFavoriteState) => GestureDetector(
                                  onTap: () => context.read<SetFavoriteCubit>().change(!isFavoriteState),
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFFFF704B)),
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          isFavoriteState ? 'LIKED' : 'I LIKE IT',
                                          style: const TextStyle(
                                            color: Color(0xFFFF704B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(width: 12),
                                        isFavoriteState ? const Icon(
                                          Icons.favorite,
                                          color: Color(0xFFFF704B),
                                          size: 24,
                                        ) : const Icon(
                                          Icons.favorite_outline,
                                          color: Color(0xFFFF704B),
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Objects',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          EditionCollection(items: edition.children),
                        ],
                      ),
                    ),
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
