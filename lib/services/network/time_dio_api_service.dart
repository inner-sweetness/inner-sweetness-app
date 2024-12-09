import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/http/http_constants.dart';

class TimeDioApiService {
  late Dio dio;
  static final TimeDioApiService _instance =
      TimeDioApiService._internal();

  factory TimeDioApiService() {
    return _instance;
  }

  TimeDioApiService._internal() {
    dio = Dio()
      ..options = BaseOptions(
        baseUrl: HTTPConstants.time,
      )
    ;
  }

  Future<Map<String, Object?>?> getRequest() async {
    try {
      var response = await dio.get('');

      return response.data as Map<String, Object?>;
    } on DioException catch (err) {
      if (kDebugMode) {
        print('Time request error: $err');
      }
      rethrow;
    }
  }
}
