import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/edition/edition_view.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class FavoriteItemBottomSheet extends StatefulWidget {
  final EditionResponse edition;
  const FavoriteItemBottomSheet({super.key, required this.edition});

  @override
  State<FavoriteItemBottomSheet> createState() => _FavoriteItemBottomSheetState();
}

class _FavoriteItemBottomSheetState extends State<FavoriteItemBottomSheet> {
  final loadingDialog = DialogLoading();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
      listener: (context, state) {
        loadingDialog.hide(context);
        if (state is DeleteFavoriteSuccessState) {
          Navigator.pop(context, true);
        } else if (state is DeleteFavoriteLoadingState) {
          loadingDialog.show(context);
        } else if (state is DeleteFavoriteErrorState) {
          Navigator.pop(context, false);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: widget.edition.category?.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        widget.edition.coverUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          widget.edition.title ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        widget.edition.description?.isNotEmpty ?? false ?
                        Text(
                          '${widget.edition.category.label} - ${widget.edition.description ?? ""}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFADADAD),
                            fontWeight: FontWeight.w400,
                          ),
                        ) : Text(
                          widget.edition.category.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFADADAD),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final category = widget.edition.category;
                if (category == null) return;
                final editionId = widget.edition.id;
                if (editionId == null) return;
                await Navigator.of(context).push(
                  FadePageRoute(
                    builder: (context) {
                      switch(category) {
                        case EditionSearchCategory.mainEdition:
                          return EditionView(editionId: editionId);
                        default:
                          return EditionView(editionId: widget.edition.parentId ?? editionId);
                      }
                    },
                  ),
                );
                context.read<FetchFavoritesBloc>().add(const FetchFavorites());
              },
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Go to group',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.folder_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey.withOpacity(.2)),
            GestureDetector(
              onTap: () {
                final editionId = widget.edition.id;
                if (editionId == null) return;
                context.read<DeleteFavoriteBloc>().add(DeleteFavorite(editionId: editionId));
              },
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Remove from favorites',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showFavoriteItemBottomSheet(BuildContext context, { required EditionResponse edition }) async {
  return await showModalBottomSheet<bool?>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<DeleteFavoriteBloc>(create: (context) => getIt<DeleteFavoriteBloc>()),
      ],
      child: FavoriteItemBottomSheet(edition: edition),
    ),
  );
}