import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomActionBarItem {
  final Widget child;
  final VoidCallback onTap;

  const BottomActionBarItem({required this.child, required this.onTap});
}

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    this.height = 80.0,
    this.showBackground = false,
    this.children = const [],
  });

  final List<BottomActionBarItem?> children;
  final double height;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: height,
        color: const Color(0xFF1E1E1E),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children.where((c) => c != null).map((c) => _buildActionItem(c!)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(BottomActionBarItem item) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: item.child is ConsumerWidget
              ? item.child
              : Consumer(builder: (_, __, ___) => item.child),
        ),
      ),
    );
  }
}
