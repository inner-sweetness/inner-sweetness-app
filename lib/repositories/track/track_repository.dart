import 'dart:convert';

import 'package:medito/constants/constants.dart';
import 'package:medito/models/models.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/services/network/dio_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_repository.g.dart';

abstract class TrackRepository {
  Future<TrackModel> fetchTrack(String trackId);

  Future<List<TrackModel>> fetchTrackFromPreference();

  Future<void> addTrackInPreference(List<TrackModel> trackList);

  Future<void> addCurrentlyPlayingTrackInPreference(
    TrackModel trackModel,
  );

  Future<void> removeCurrentlyPlayingTrackInPreference();

  Future<TrackModel?> fetchCurrentlyPlayingTrackFromPreference();
}

class TrackRepositoryImpl extends TrackRepository {
  final DioApiService client;
  final Ref ref;

  TrackRepositoryImpl({required this.ref, required this.client});

  @override
  Future<TrackModel> fetchTrack(String trackId) async {
    if (trackId == 'track_1') {
      return TrackModel(
        id: 'track-model-1',
        title: 'Podcast',
        description: 'Could you be Love',
        coverUrl: '',
        isPublished: true,
        hasBackgroundSound: true,
        audio: <TrackAudioModel>[
          TrackAudioModel(
            guideName: '',
            files: <TrackFilesModel>[
              TrackFilesModel(
                id: 'track-file-model-1',
                path: '',
                duration: 5 * 60 * 1000,
              ),
            ],
          ),
        ],
      );
    }
    return TrackModel(
      id: 'track-model-2',
      title: 'Sweet Challenge',
      description: 'An energy without words.',
      coverUrl: '',
      isPublished: true,
      hasBackgroundSound: true,
      audio: <TrackAudioModel>[
        TrackAudioModel(
          guideName: '',
          files: <TrackFilesModel>[
            TrackFilesModel(
              id: 'track-file-model-2',
              path: '',
              duration: 30 * 60 * 1000,
            ),
          ],
        ),
      ],
    );
    // var response = await client.getRequest('${HTTPConstants.tracks}/$trackId');
    // return TrackModel.fromJson(response);
  }

  @override
  Future<List<TrackModel>> fetchTrackFromPreference() async {
    var downloadedTrackList = <TrackModel>[];
    var downloadedTrackFromPref = ref
        .read(sharedPreferencesProvider)
        .getString(SharedPreferenceConstants.downloads);
    if (downloadedTrackFromPref != null) {
      var tempList = [];
      tempList = json.decode(downloadedTrackFromPref);
      for (var element in tempList) {
        downloadedTrackList.add(TrackModel.fromJson(element));
      }
    }

    return downloadedTrackList;
  }

  @override
  Future<void> addTrackInPreference(List<TrackModel> trackList) async {
    await ref.read(sharedPreferencesProvider).setString(
          SharedPreferenceConstants.downloads,
          json.encode(trackList),
        );
  }

  @override
  Future<void> addCurrentlyPlayingTrackInPreference(
    TrackModel track,
  ) async {
    await ref.read(sharedPreferencesProvider).setString(
          SharedPreferenceConstants.currentPlayingTrack,
          json.encode(track),
        );
  }

  @override
  Future<void> removeCurrentlyPlayingTrackInPreference() async {
    await ref.read(sharedPreferencesProvider).remove(
          SharedPreferenceConstants.currentPlayingTrack,
        );
  }

  @override
  Future<TrackModel?> fetchCurrentlyPlayingTrackFromPreference() async {
    var track = ref.read(sharedPreferencesProvider).getString(
          SharedPreferenceConstants.currentPlayingTrack,
        );
    if (track != null) {
      return TrackModel.fromJson(json.decode(track));
    }

    return null;
  }
}

@riverpod
TrackRepository trackRepository(TrackRepositoryRef ref) {
  return TrackRepositoryImpl(ref: ref, client: DioApiService());
}
