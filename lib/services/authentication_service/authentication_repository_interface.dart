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

abstract class IAuthenticationRepository {
  Future<RegisterResponse> register({ required RegisterRequest request });
  Future<LoginResponse> login({ required LoginRequest request });
  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request });
  Future<SendCodeResponse> sendCode({ required SendCodeRequest request });
  Future<VerifyCodeResponse> verifyCode({ required VerifyCodeRequest request });
  Future<ResetPasswordResponse> resetPassword({ required ResetPasswordRequest request });
}