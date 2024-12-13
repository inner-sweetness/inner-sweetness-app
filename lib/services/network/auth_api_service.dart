import 'package:dio/dio.dart';

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
}
