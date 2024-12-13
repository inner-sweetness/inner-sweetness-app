import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';

@singleton
class AppConfig {
  AppConfig(this._sharedPreferencesService);

  final SharedPreferencesService _sharedPreferencesService;
  BuildContext? context;

  Future<void> initialize() async {
    await _sharedPreferencesService.init();
  }
}