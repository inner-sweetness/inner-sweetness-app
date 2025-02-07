import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/article/article_view.dart';
import 'package:medito/views/audio/audio_view.dart';
import 'package:medito/views/edition/edition_view.dart';
import 'package:medito/views/explore/logic/bloc/search_edition_bloc/search_edition_bloc.dart';

class ExploreResultCard extends StatelessWidget {
  final EditionResponse edition;
  const ExploreResultCard({super.key, required this.edition});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final category = edition.category;
        if (category == null) return;
        final editionId = edition.id;
        if (editionId == null) return;
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
        context.read<SearchEditionBloc>().add(const SearchEdition());
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 153,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: edition.category?.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                edition.coverUrl ?? '',
                fit: BoxFit.fill,
                height: 183,
                width: 135,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              edition.title ?? '',
              style: TextStyle(
                color: edition.category == EditionSearchCategory.article ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 12),
            Text(
              edition.duration ?? '',
              style: TextStyle(
                color: edition.category == EditionSearchCategory.article ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            if (edition.description?.isNotEmpty ?? false)
              ...[
                const SizedBox(height: 12),
                Text(
                  edition.description ?? '',
                  style: TextStyle(
                    color: edition.category == EditionSearchCategory.article ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
          ],
        ),
      ),
    );
  }
}
