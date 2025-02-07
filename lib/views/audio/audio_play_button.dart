import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/providers/pack/pack_provider.dart';
import 'package:medito/providers/player/player_provider.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/utils/permission_handler.dart';
import 'package:medito/views/player/player_view.dart';

class AudioPlayButton extends ConsumerWidget {
  final EditionResponse edition;
  const AudioPlayButton({super.key, required this.edition});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        try {
          await PermissionHandler.requestMediaPlaybackPermission(context);
          final track = edition.toTrackModel();
          await ref.read(playerProvider.notifier).loadSelectedTrack(
                trackModel: track,
                file: track.audio.first.files.first,
              );
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlayerView(),
            ),
          ).then((value) => {
                ref.invalidate(packProvider),
              });
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: edition.category?.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
