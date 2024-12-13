import 'package:medito/services/authentication_service/model/request/login_request.dart';
import 'package:medito/services/authentication_service/model/request/refresh_token_request.dart';
import 'package:medito/services/authentication_service/model/request/register_request.dart';
import 'package:medito/services/authentication_service/model/response/login_response.dart';
import 'package:medito/services/authentication_service/model/response/refresh_token_response.dart';
import 'package:medito/services/authentication_service/model/response/register_response.dart';

abstract class IAuthenticationRepository {
  Future<RegisterResponse> register({ required RegisterRequest request });
  Future<LoginResponse> login({ required LoginRequest request });
  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request });
}