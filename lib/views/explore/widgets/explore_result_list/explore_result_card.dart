import 'package:flutter/material.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/article/article_view.dart';
import 'package:medito/views/audio/audio_view.dart';
import 'package:medito/views/edition/edition_view.dart';

class ExploreResultCard extends StatelessWidget {
  final EditionResponse item;
  const ExploreResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final category = item.category;
        if (category == null) return;
        final editionId = item.id;
        if (editionId == null) return;
        Navigator.of(context).push(
          FadePageRoute(
            builder: (context) {
              switch(category) {
                case EditionSearchCategory.mainEdition:
                  return EditionView(editionId: editionId);
                case EditionSearchCategory.article:
                  return ArticleView(item: item);
                case EditionSearchCategory.podcast:
                  return AudioView(item: item);
                case EditionSearchCategory.sweetGym:
                  return AudioView(item: item);
              }
            },
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 153,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: item.category?.color,
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
                item.coverUrl ?? '',
                fit: BoxFit.fill,
                height: 183,
                width: 135,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.title ?? '',
              style: TextStyle(
                color: item.category == EditionSearchCategory.article ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 12),
            Text(
              item.duration ?? '',
              style: TextStyle(
                color: item.category == EditionSearchCategory.article ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            if (item.description?.isNotEmpty ?? false)
              ...[
                const SizedBox(height: 12),
                Text(
                  item.description ?? '',
                  style: TextStyle(
                    color: item.category == EditionSearchCategory.article ? Colors.white : Colors.black,
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
