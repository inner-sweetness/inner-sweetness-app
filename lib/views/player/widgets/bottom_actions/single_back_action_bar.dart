import 'package:flutter/material.dart';

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
      children: <BottomActionBarItem>[
        BottomActionBarItem(
          child: const Icon(Icons.arrow_back_outlined),
          // child: HugeIcon(
          //   icon: showCloseIcon ? HugeIcons.solidSharpMultiplicationSign : HugeIcons.solidSharpArrowLeft02,
          //   color: ColorConstants.white,
          // ),
          onTap: onBackPressed,
        )
      ],
    );
  }
}
