// import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/meditation/track_provider.dart';
import 'bottom_action_bar.dart';

class TrackViewBottomBar extends ConsumerWidget {
  final String trackId;
  final VoidCallback onBackPressed;

  const TrackViewBottomBar({
    Key? key,
    required this.trackId,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final favoriteStatus = ref.watch(favoriteStatusProvider(trackId: trackId));

    const dailyMeditationId = 'BmTFAyYt8jVMievZ'; // from back end :(
    var isDailyMeditation = trackId == dailyMeditationId;
    // var colour = favoriteStatus ? ColorConstants.lightPurple : ColorConstants.white;
    // var icon = favoriteStatus ? const Icon(Icons.play_arrow) : const Icon(Icons.pause);

    return BottomActionBar(
      children: <BottomActionBarItem?>[
        BottomActionBarItem(
          child: const Icon(Icons.arrow_back),
          // child: HugeIcon(icon: HugeIcons.solidSharpArrowLeft02, color: Colors.white,),
          onTap: onBackPressed,
        ),
        isDailyMeditation
            ? null
            : BottomActionBarItem(
                child: const Icon(Icons.star),
                // child: HugeIcon(
                //   icon: icon,
                //   color: colour,
                // ),
                onTap: () {
                  ref.read(favoriteStatusProvider(trackId: trackId).notifier).toggle();
                },
              ),
      ],
    );
  }
}
