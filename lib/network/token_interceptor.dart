import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medito/injection.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/refresh_token_request.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_keys.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';
import 'package:medito/widgets/unauthorized_dialog.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.forbidden || (err.requestOptions.extra['is_retry'] ?? false)) {
      super.onError(err, handler);
      return;
    }
    final sharedPreferencesService = getIt<SharedPreferencesService>();
    final refreshToken = sharedPreferencesService.getString(SharedPreferencesKeys.refreshTokenKey);
    if (refreshToken.isNotEmpty) {
      final authenticationService = getIt<AuthenticationService>();
      try {
        final request = RefreshTokenRequest(refreshToken: refreshToken);
        await authenticationService.refreshToken(request: request);
        try {
          final newOptions = err.requestOptions.copyWith(
            extra: {
              ...err.requestOptions.extra,
              'is_retry': true,
            },
          );
          final response = await getIt<DioClient>().fetchRaw(requestOptions: newOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          super.onError(err, handler);
          return;
        }
      } catch (e) {
        await sharedPreferencesService.setString(SharedPreferencesKeys.tokenKey, '');
        await sharedPreferencesService.setString(SharedPreferencesKeys.refreshTokenKey, '');
      }
    }
    showUnauthorizedDialog();
    super.onError(err, handler);
  }


}