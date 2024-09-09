import 'package:medito/constants/constants.dart';
import 'package:medito/widgets/shimmers/widgets/box_shimmer_widget.dart';
import 'package:flutter/material.dart';

class BackgroundSoundsShimmerWidget extends StatelessWidget {
  const BackgroundSoundsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          BoxShimmerWidget(
            height: 130,
          ),
          height8,
          Column(
            children: List.generate(6, (index) => _shimmerList(size)),
          ),
        ],
      ),
    );
  }

  Padding _shimmerList(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 100,
        width: size.width,
        color: ColorConstants.greyIsTheNewGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: BoxShimmerWidget(
                height: 10,
                width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: BoxShimmerWidget(
                height: 10,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
