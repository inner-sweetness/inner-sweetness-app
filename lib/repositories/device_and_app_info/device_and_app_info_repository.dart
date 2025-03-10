import 'dart:io';
import 'dart:ui';

import 'package:medito/models/models.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'device_and_app_info_repository.g.dart';

abstract class DeviceAndAppInfoRepository {
  Future<DeviceAndAppInfoModel> getDeviceAndAppInfo();
}

class DeviceInfoRepositoryImpl extends DeviceAndAppInfoRepository {
  DeviceInfoRepositoryImpl();

  @override
  Future<DeviceAndAppInfoModel> getDeviceAndAppInfo() async {
    String? deviceModel;
    String? deviceOS;
    String? devicePlatform;
    String buildNumber;
    String appVersion;
    var deviceInfo = DeviceInfoPlugin();
    var packageInfo = await PackageInfo.fromPlatform();
    var languageCode = PlatformDispatcher.instance.locale.languageCode;
    var currencySymbol = NumberFormat.simpleCurrency(locale: languageCode).currencySymbol;
    var currencyName = NumberFormat.simpleCurrency(locale: languageCode).currencyName;

    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceModel = iosInfo.utsname.machine;
      deviceOS = iosInfo.utsname.sysname;
      devicePlatform = 'iOS';
    } else if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
      deviceOS = androidInfo.version.release;
      devicePlatform = 'android';
    }

    return DeviceAndAppInfoModel(
      model: deviceModel!,
      os: deviceOS!,
      platform: devicePlatform!,
      buildNumber: buildNumber,
      appVersion: appVersion,
      languageCode: languageCode,
      currencySymbol: currencySymbol,
      currencyName: currencyName ?? '',
    );
  }
}

@riverpod
DeviceAndAppInfoRepository deviceAndAppInfoRepository(_) {
  return DeviceInfoRepositoryImpl();
}
