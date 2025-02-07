import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';

import '../../../../constants/colors/color_constants.dart';
import 'bottom_action_bar.dart';

class SingleBackButtonActionBar extends StatelessWidget {
  const SingleBackButtonActionBar({
    super.key,
    required this.onBackPressed,
    this.showCloseIcon = false,
  });

  final VoidCallback onBackPressed;
  final bool showCloseIcon;

  @override
  Widget build(BuildContext context) {
    return BottomActionBar(
      leftItem: BottomActionBarItem(
        child: Text('close'),
        onTap: onBackPressed,
      ),
    );
  }
}
