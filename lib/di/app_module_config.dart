import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/network/logging_interceptor.dart';
import 'package:medito/network/token_interceptor.dart';

@module
abstract class AppConfigModule {
  @LazySingleton()
  Dio get dio {
    final client = Dio();
    client.interceptors.add(LoggingInterceptors());
    client.interceptors.add(TokenInterceptor());
    return client;
  }
}