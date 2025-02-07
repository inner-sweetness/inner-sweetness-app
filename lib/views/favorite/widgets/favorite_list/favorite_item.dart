import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/favorite/favorite_item_bottom_sheet/favorite_item_bottom_sheet.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';

class FavoriteItem extends StatelessWidget {
  final EditionResponse edition;
  const FavoriteItem({super.key, required this.edition});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final removed = await showFavoriteItemBottomSheet(context, edition: edition);
        if (removed == null) return;
        if (removed) {
          AppSnackBar.showSuccessSnackBar(
            context,
            background: Colors.green,
            message: 'I has been removed from favorites!',
          );
        } else {
          AppSnackBar.showErrorSnackBar(context, message: 'Something went wrong');
        }
        context.read<FetchFavoritesBloc>().add(const FetchFavorites());
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
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
                color: edition.category?.color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  edition.coverUrl ?? '',
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
                    edition.title ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  edition.description?.isNotEmpty ?? false ?
                    Text(
                      '${edition.category.label} - ${edition.description ?? ""}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFADADAD),
                        fontWeight: FontWeight.w400,
                      ),
                    ) : Text(
                      edition.category.label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFADADAD),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
