import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medito/views/edition/widgets/edition_collection/edition_collection.dart';
import 'package:medito/views/explore/explore_view.dart';
import 'package:medito/views/explore/widgets/explore_category_list/explore_category_list.dart';

class CollectionItem {
  final String title;
  final String duration;
  final String description;
  final String image;
  final String createdAt;
  final ExploreCategory category;

  CollectionItem({
    required this.title,
    required this.duration,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.category,
  });
}

class EditionView extends StatelessWidget {
  final ExploreItem item;
  const EditionView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final list = <CollectionItem>[
      CollectionItem(
        title: 'Tale as old as time',
        duration: '10 min',
        description: '',
        image: 'assets/images/explore/explore_image_1.png',
        createdAt: '',
        category: ExploreCategory.article,
      ),
      CollectionItem(
        title: 'Could you be Love',
        duration: '30 min',
        description: '',
        image: 'assets/images/explore/explore_image_1.png',
        createdAt: '',
        category: ExploreCategory.podcast,
      ),
      CollectionItem(
        title: 'An energy without words.',
        duration: '30 min',
        description: '',
        image: 'assets/images/explore/explore_image_1.png',
        createdAt: '',
        category: ExploreCategory.sweetGym,
      ),
    ];
    return Scaffold(
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
                      child: Image.asset(
                        item.image,
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
                    item.title,
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
                        item.duration,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFADADAD),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item.createdAt,
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF704B)),
                          borderRadius: BorderRadius.circular(56),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'I LIKE IT',
                              style: TextStyle(
                                color: Color(0xFFFF704B),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.favorite_outline,
                              color: Color(0xFFFF704B),
                              size: 24,
                            ),
                          ],
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
                  EditionCollection(items: list),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
