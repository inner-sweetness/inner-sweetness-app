import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medito/services/model/request/login_request.dart';
import 'package:medito/services/model/request/refresh_token_request.dart';
import 'package:medito/services/model/request/register_request.dart';
import 'package:medito/services/model/response/login_response.dart';
import 'package:medito/services/model/response/refresh_token_response.dart';
import 'package:medito/services/model/response/register_response.dart';

import '../../constants/http/http_constants.dart';

class AuthDioApiService {
  late Dio dio;
  static final AuthDioApiService _instance =
      AuthDioApiService._internal();

  factory AuthDioApiService() {
    return _instance;
  }

  AuthDioApiService._internal() {
    dio = Dio()
      ..options = BaseOptions(
        baseUrl: HTTPConstants.baseUrl,
      )
    ;
  }

  Future<RegisterResponse> register({ required RegisterRequest request }) async {
    try {
      final data = request.toJson();
      var response = await dio.post('/auth/register', data: data);
      return RegisterResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (err) {
      if (kDebugMode) {
        print('Auth request error: $err');
      }
      rethrow;
    }
  }

  Future<LoginResponse> login({ required LoginRequest request }) async {
    try {
      var response = await dio.post('/auth/login', data: request.toJson());
      return LoginResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (err) {
      if (kDebugMode) {
        print('Auth request error: $err');
      }
      rethrow;
    }
  }

  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request }) async {
    try {
      var response = await dio.post('/auth/refresh', data: request.toJson());
      return RefreshTokenResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (err) {
      if (kDebugMode) {
        print('Auth request error: $err');
      }
      rethrow;
    }
  }
}
