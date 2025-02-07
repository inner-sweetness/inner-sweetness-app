import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/authentication_service/authentication_repository_interface.dart';
import 'package:medito/services/authentication_service/model/request/login_request.dart';
import 'package:medito/services/authentication_service/model/request/refresh_token_request.dart';
import 'package:medito/services/authentication_service/model/request/register_request.dart';
import 'package:medito/services/authentication_service/model/request/reset_password_request.dart';
import 'package:medito/services/authentication_service/model/request/send_code_request.dart';
import 'package:medito/services/authentication_service/model/request/verify_code_request.dart';
import 'package:medito/services/authentication_service/model/response/login_response.dart';
import 'package:medito/services/authentication_service/model/response/refresh_token_response.dart';
import 'package:medito/services/authentication_service/model/response/register_response.dart';
import 'package:medito/services/authentication_service/model/response/reset_password_response.dart';
import 'package:medito/services/authentication_service/model/response/send_code_response.dart';
import 'package:medito/services/authentication_service/model/response/verify_code_response.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_keys.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';

@LazySingleton(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final DioClient _dioClient;
  final SharedPreferencesService _sharedPreferencesService;

  AuthenticationRepository(this._dioClient, this._sharedPreferencesService);

  @override
  Future<RegisterResponse> register({ required RegisterRequest request }) async {
    final data = request.toJson();
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/register', body: data);
    return RegisterResponse.fromJson(response.data as Map<String, Object?>);
  }

  @override
  Future<LoginResponse> login({ required LoginRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/login', body: request.toJson());
    final loginResponse = LoginResponse.fromJson(response.data as Map<String, Object?>);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.tokenKey, loginResponse.accessToken);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.refreshTokenKey, loginResponse.refreshToken);
    return loginResponse;
  }

  @override
  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/refresh', body: request.toJson());
    final refreshTokenResponse = RefreshTokenResponse.fromJson(response.data as Map<String, Object?>);
    await _sharedPreferencesService.setString(SharedPreferencesKeys.tokenKey, refreshTokenResponse.accessToken);
    return refreshTokenResponse;
  }

  @override
  Future<SendCodeResponse> sendCode({ required SendCodeRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/recover/send-code', body: request.toJson());
    return SendCodeResponse.fromJson(response.data as Map<String, Object?>);
  }

  @override
  Future<VerifyCodeResponse> verifyCode({ required VerifyCodeRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/recover/verify-code', body: request.toJson());
    return VerifyCodeResponse.fromJson(response.data as Map<String, Object?>);
  }

  @override
  Future<ResetPasswordResponse> resetPassword({ required ResetPasswordRequest request }) async {
    var response = await _dioClient.post('${HTTPConstants.baseUrl}/auth/recover/reset-password', body: request.toJson());
    return ResetPasswordResponse.fromJson(response.data as Map<String, Object?>);
  }
}
