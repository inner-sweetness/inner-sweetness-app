import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptors extends Interceptor {

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final logger = Logger();
    var headers = <String>[], queryParams = <String>[];
    options.headers.forEach((k, v) => headers.add('$k: $v'));
    options.queryParameters.forEach((k, v) => queryParams.add('$k: $v'));
    logger.d('''
        REQUEST ${options.method.toUpperCase()} ${'${options.baseUrl}${options.path}'}
        Headers: ${headers.join('\n')}
        Query Parameters: ${queryParams.join('\n')}
        Body: ${options.data}
        END ${options.method.toUpperCase()}
    ''');
    super.onRequest(options, handler);
    // return super.onRequest(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final logger = Logger();
    var headers = <String>[], queryParams = <String>[];
    err.requestOptions.headers.forEach((k, v) => headers.add('$k: $v'));
    err.requestOptions.queryParameters.forEach((k, v) => queryParams.add('$k: $v'));
    logger.d('''
        ERROR ${err.message} ${(err.requestOptions.baseUrl + err.requestOptions.path)}
        Headers: ${headers.join('\n')}
        Query Parameters: ${queryParams.join('\n')}
        Message: ${err.response?.data ?? (err.error != null ? err.message :'Unknown Error')}
    ''');
    super.onError(err, handler);
    // return super.onError(dioError);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logger = Logger();
    var requestHeaders = <String>[], responseHeaders = <String>[];
    response.headers.forEach((k, v) => responseHeaders.add('$k: $v'));
    response.requestOptions.headers.forEach((k, v) => requestHeaders.add('$k: $v'));
    logger.d('''
        RESPONSE ${response.statusCode} ${(response.requestOptions.baseUrl + response.requestOptions.path)}
        Request Headers: ${requestHeaders.join('\n')}
        Response Headers: ${responseHeaders.join('\n')}
        Message: ${response.data}
    ''');
    super.onResponse(response, handler);
    // return super.onResponse(response);
  }
}