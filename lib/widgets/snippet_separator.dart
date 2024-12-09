import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SnippetSeparator extends StatelessWidget {
  const SnippetSeparator.left({super.key, this.height = 1, this.color = Colors.black, this.flipped = true});
  const SnippetSeparator.right({super.key, this.height = 1, this.color = Colors.black, this.flipped = false});

  final double height;
  final Color color;
  final bool flipped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final boxWidth = constraints.constrainWidth();
                const dashWidth = 5.0;
                final dashHeight = height;
                final dashCount = (boxWidth / (2 * dashWidth)).floor();
                return Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: color),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          Align(
            alignment: flipped ? Alignment.centerLeft : Alignment.centerRight,
            child: Transform.flip(
              flipX: flipped,
              child: SvgPicture.asset('assets/images/scissors_icon.svg'),
            ),
          ),
        ],
      ),
    );
  }
}