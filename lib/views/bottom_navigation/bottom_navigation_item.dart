import 'package:flutter/material.dart';
import 'package:medito/constants/colors/color_constants.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const BottomNavigationItem({super.key, this.label = '', this.selected = false, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: selected
              ? ColorConstants.black
              : ColorConstants.graphite,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected
                ? ColorConstants.black
                : ColorConstants.graphite,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
