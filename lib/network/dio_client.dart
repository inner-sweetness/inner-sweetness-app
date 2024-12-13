import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/network/app_api_exception.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_keys.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';

@injectable
class DioClient {
  final Dio _client;
  final SharedPreferencesService _sharedPreferencesService;

  DioClient(this._client, this._sharedPreferencesService);

  Future<Response> get(
      String url, {
        Map<String, dynamic>? headers,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.get(
        url,
        options: Options(headers: dioHeaders),
        queryParameters: queryParams,
        cancelToken: cancelToken
    );
  }

  Future<Response> post(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.post(
      url,
      data: body,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> put(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.put(
      url,
      data: body,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> patch(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.patch(
      url,
      data: body,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> delete(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.delete(
      url,
      data: body,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> download(
      String url,
      String savePath, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    return await _client.download(
      url,
      savePath,
      data: body,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> upload(
      String url, {
        Map<String, dynamic>? headers,
        String path = '',
        CancelToken? cancelToken,
        Map<String, String>? queryParams,
        Duration? connectionTimeout,
        String? language,
      }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final dioHeaders = (headers ?? <String, dynamic>{});
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    dioHeaders.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
    });
    if (connectionTimeout != null) {
      _client.options.connectTimeout = connectionTimeout;
    }
    final file = File(path);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    return await _client.post(
      url,
      data: formData,
      options: Options(headers: dioHeaders),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );
  }

  Future<Response> fetchRaw({ required RequestOptions requestOptions }) async {
    if (!await _checkInternetConnection()) {
      throw const AppApiException('Internet connection Error');
    }
    final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
    requestOptions.headers.addAll({
      if (token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return await _client.fetch(requestOptions);
  }

  Future<bool> _checkInternetConnection({bool test = false}) async {
    return true;
  }
}
