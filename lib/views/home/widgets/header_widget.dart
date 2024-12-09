import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'header/home_header_widget.dart';

class HeaderWidget extends ConsumerStatefulWidget {
  const HeaderWidget({
    super.key,
    required this.onStatsButtonTap,
    required this.greeting,
  });

  final String greeting;
  final VoidCallback onStatsButtonTap;

  @override
  ConsumerState<HeaderWidget> createState() => _HeaderAndAnnouncementWidgetState();
}

class _HeaderAndAnnouncementWidgetState extends ConsumerState<HeaderWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return HomeHeaderWidget(greeting: widget.greeting);
  }

  @override
  bool get wantKeepAlive => false;
}
