import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/authentication_service/authentication_repository_interface.dart';
import 'package:medito/services/authentication_service/model/request/login_request.dart';
import 'package:medito/services/authentication_service/model/request/refresh_token_request.dart';
import 'package:medito/services/authentication_service/model/request/register_request.dart';
import 'package:medito/services/authentication_service/model/response/login_response.dart';
import 'package:medito/services/authentication_service/model/response/refresh_token_response.dart';
import 'package:medito/services/authentication_service/model/response/register_response.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_keys.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';

@LazySingleton(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final DioClient _dioClient;
  final SharedPreferencesService _sharedPreferencesService;

  AuthenticationRepository(this._dioClient, this._sharedPreferencesService);

  Future<RegisterResponse> register({ required RegisterRequest request }) async {
    final data = request.toJson();
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/register', body: data);
    return RegisterResponse.fromJson(response.data as Map<String, Object?>);
  }

  Future<LoginResponse> login({ required LoginRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/login', body: request.toJson());
    final loginResponse = LoginResponse.fromJson(response.data as Map<String, Object?>);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.tokenKey, loginResponse.accessToken);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.refreshTokenKey, loginResponse.refreshToken);
    return loginResponse;
  }

  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request }) async {
    var response = await _dioClient.post('/auth/refresh', body: request.toJson());
    final refreshTokenResponse = RefreshTokenResponse.fromJson(response.data as Map<String, Object?>);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.tokenKey, refreshTokenResponse.accessToken);
    return refreshTokenResponse;
  }
}
