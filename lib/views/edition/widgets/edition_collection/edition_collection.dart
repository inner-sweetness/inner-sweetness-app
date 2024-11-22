import 'package:flutter/material.dart';
import 'package:medito/views/edition/edition_view.dart';
import 'package:medito/views/edition/widgets/edition_collection/edition_item.dart';

class EditionCollection extends StatelessWidget {
  final List<CollectionItem> items;
  const EditionCollection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(children: items.map((i) => EditionItem(item: i)).toList());
  }
}
