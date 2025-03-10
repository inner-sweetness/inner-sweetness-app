import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medito/constants/constants.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const _errorKey = 'error';
const _messageKey = 'message';

// ignore: avoid_dynamic_calls
class DioApiService {
  static final DioApiService _instance = DioApiService._internal();
  late Dio dio;

  factory DioApiService() {
    return _instance;
  }

  // Private constructor
  DioApiService._internal() {
    dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      baseUrl: contentBaseUrl,
    );
    if (kDebugMode) {
      dio.interceptors.add(
        InterceptorsWrapper(onError: (e, handler) => _onError(e, handler)),
      );
      dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ));
    }
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (kReleaseMode) {
      await _captureException(err);
    }
    handler.reject(err);
  }

  Future<void> _captureException(dynamic err) async {
    var exceptionData = {
      'error': err.toString(),
      'endpoint':
          err is DioException ? err.requestOptions.path.toString() : 'Unknown',
      'response': err is DioException ? err.response.toString() : 'Unknown',
      'serverMessage': err is DioException ? err.message.toString() : 'Unknown',
    };

    await Sentry.captureException(
      exceptionData,
      stackTrace: err is DioException ? err.stackTrace : StackTrace.current,
    );
  }

  // ignore: avoid-dynamic
  Future<dynamic> getRequest(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  // ignore: avoid-dynamic
  Future<dynamic> postRequest(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  // ignore: avoid-dynamic
  Future<dynamic> deleteRequest(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  CustomException _returnDioErrorResponse(DioException error) {
    var data = error.response?.data;
    var message;
    if (data is! String) {
      message = data?[_errorKey] ?? data?[_messageKey];
    }

    if (error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      throw FetchDataException(
        error.response?.statusCode,
        StringConstants.connectionTimeout,
      );
    }

    switch (error.response?.statusCode) {
      case 400:
        throw BadRequestException(
          error.response?.statusCode,
          StringConstants.badRequest,
        );
      case 401:
        throw UnauthorizedException(
          error.response?.statusCode,
          StringConstants.unauthorizedRequest,
        );
      case 403:
        throw UnauthorizedException(
          error.response?.statusCode,
          StringConstants.accessForbidden,
        );
      case 404:
        throw FetchDataException(
          error.response?.statusCode,
          message ?? StringConstants.anErrorOccurred,
        );
      case 500:
      default:
        throw FetchDataException(
          error.response?.statusCode ?? 500,
          StringConstants.anErrorOccurred,
        );
    }
  }
}

class CustomException implements Exception {
  final int? statusCode;
  final String? message;

  CustomException([this.statusCode, this.message]);

  @override
  String toString() {
    return '$message${statusCode != null ? ': $statusCode' : ''}';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([int? statusCode, String? message])
      : super(statusCode, message);
}

class BadRequestException extends CustomException {
  BadRequestException([int? statusCode, message]) : super(statusCode, message);
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([int? statusCode, message])
      : super(statusCode, message);
}

class InvalidInputException extends CustomException {
  InvalidInputException([int? statusCode, String? message])
      : super(statusCode, message);
}
