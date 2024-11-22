import 'package:flutter/material.dart';

class ExploreCategoryItem extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;
  final bool selected;
  const ExploreCategoryItem({super.key, required this.selected, required this.color, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.only(
          left: 2,
          top: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              if (selected)
                ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}
