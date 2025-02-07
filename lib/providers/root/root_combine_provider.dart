import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/providers/time/time_provider.dart';
import 'package:medito/views/time/time_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/strings/shared_preference_constants.dart';
import '../../constants/types/type_constants.dart';
import '../../utils/stats_updater.dart';
import '../../views/maintenance/maintenance_view.dart';
import '../maintenance/maintenance_provider.dart';

final rootCombineProvider = Provider.family<void, BuildContext>(
  (ref, context) {
    ref.read(deviceAppAndUserInfoProvider);
    // checkMaintenance(ref, context);
    // checkTime(ref, context);

    if (Platform.isIOS) {
      var streamEvent = iosAudioHandler.iosStateStream
          .map((event) => event.playerState.processingState)
          .distinct();
      streamEvent.forEach((element) {
        getUserToken().then(
          (userToken) async {
            if (element == ProcessingState.completed) {
              var mediaItem = iosAudioHandler.mediaItem.value;
              var payload = {
                TypeConstants.trackIdKey: iosAudioHandler.trackState.id,
                TypeConstants.durationIdKey:
                    iosAudioHandler.duration?.inMilliseconds ?? 0,
                TypeConstants.fileIdKey: mediaItem?.title ?? '',
                TypeConstants.guideIdKey:
                    iosAudioHandler.trackState.artist ?? '',
                TypeConstants.timestampIdKey:
                    DateTime.now().millisecondsSinceEpoch,
                UpdateStatsConstants.userTokenKey: userToken,
              };
              await handleStats(payload);
            }
          },
        );
      });
    }
  },
);

Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferenceConstants.userToken);
}

void checkMaintenance(ProviderRef<void> ref, BuildContext context) {
  ref.read(fetchMaintenanceProvider.future).then(
    (maintenanceData) {
      ref.read(deviceAndAppInfoProvider.future).then(
        (deviceInfo) {
          var buildNumber = int.parse(deviceInfo.buildNumber);
          if (maintenanceData.isUnderMaintenance ||
              (maintenanceData.minimumBuildNumber ?? 0) > buildNumber) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MaintenanceView(
                  maintenanceModel: maintenanceData,
                ),
              ),
            );
          }
        },
      );
    },
  );
}

void checkTime(ProviderRef<void> ref, BuildContext context) {
  ref.read(fetchTimeProvider.future).then(
        (timeData) {
          final now = DateTime.tryParse(timeData.dateTime ?? '') ?? DateTime.now();
          final diff = DateTime(2024, 11, 30).difference(now).inDays;
          if (diff > 0) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeView(
                timeModel: timeData,
              ),
            ),
          );
    },
  );
}
