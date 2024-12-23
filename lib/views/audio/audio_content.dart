import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/audio/audio_play_button.dart';
import 'package:medito/views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_cubit/set_favorite_cubit.dart';

class AudioContent extends StatefulWidget {
  final EditionResponse edition;
  const AudioContent({super.key, required this.edition});

  @override
  State<AudioContent> createState() => _AudioContentState();
}

class _AudioContentState extends State<AudioContent> {

  @override
  void initState() {
    context.read<SetFavoriteCubit>().change(widget.edition.isFavorite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetFavoriteCubit, bool>(
      listener: (context, bool isFavoriteState) {
        widget.edition.isFavorite = isFavoriteState;
        final editionId = widget.edition.id;
        if (editionId == null) return;
        if (isFavoriteState) {
          context.read<AddFavoriteBloc>().add(AddFavorite(editionId: editionId));
        } else {
          context.read<DeleteFavoriteBloc>().add(DeleteFavorite(editionId: editionId));
        }
      },
      child: Scaffold(
        backgroundColor: widget.edition.category?.background,
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
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Image.network(
                widget.edition.coverUrl ?? '',
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
                              widget.edition.title ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
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
                                color: Colors.black,
                                size: 24,
                              ) : const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
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
                            color: widget.edition.category?.color,
                          ),
                          child: Text(
                            widget.edition.category?.label ?? '',
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
                            widget.edition.duration ?? '',
                            style: const TextStyle(
                              color: Color(0xFF020202),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            DateFormat('dd EEE yyyy').format(widget.edition.createdAtDate),
                            style: const TextStyle(
                              color: Color(0xFF020202),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        widget.edition.description ?? '',
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          height: 2,
                        ),
                      ),
                      const Spacer(),
                      AudioPlayButton(edition: widget.edition),
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
}
