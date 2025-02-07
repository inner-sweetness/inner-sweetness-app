import 'package:flutter/material.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/routes/routes.dart';

class HomeHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeaderWidget({
    super.key,
    required this.greeting,
  });

  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            greeting,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: ColorConstants.white,
              height: 0,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: SourceSerif,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => handleNavigation('settings', [], context),
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72.0);
}
