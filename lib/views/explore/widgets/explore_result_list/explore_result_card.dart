import 'package:flutter/material.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/article/article_view.dart';
import 'package:medito/views/audio/audio_view.dart';
import 'package:medito/views/edition/edition_view.dart';
import 'package:medito/views/explore/explore_view.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_list.dart';

class ExploreResultCard extends StatelessWidget {
  final ExploreItem item;
  const ExploreResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        FadePageRoute(
          builder: (context) {
            switch(item.category) {
              case ExploreCategory.edition:
                return EditionView(item: item);
              case ExploreCategory.article:
                return ArticleView(item: item);
              case ExploreCategory.podcast:
                return AudioView(item: item);
              case ExploreCategory.sweetGym:
                return AudioView(item: item);
            }
          },
        ),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 153,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: item.category.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.image,
                fit: BoxFit.fill,
                height: 183,
                width: 135,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: TextStyle(
                color: item.category == ExploreCategory.article ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 12),
            Text(
              item.duration,
              style: TextStyle(
                color: item.category == ExploreCategory.article ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            if (item.description.isNotEmpty)
              ...[
                const SizedBox(height: 12),
                Text(
                  item.description,
                  style: TextStyle(
                    color: item.category == ExploreCategory.article ? Colors.white : Colors.black,
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
