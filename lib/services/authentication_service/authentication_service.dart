import 'package:injectable/injectable.dart';
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

@injectable
class AuthenticationService {
  final IAuthenticationRepository _repository;

  AuthenticationService(this._repository);

  Future<RegisterResponse> register({ required RegisterRequest request }) => _repository.register(request: request);
  Future<LoginResponse> login({ required LoginRequest request }) => _repository.login(request: request);
  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request }) => _repository.refreshToken(request: request);
  Future<SendCodeResponse> sendCode({ required SendCodeRequest request }) => _repository.sendCode(request: request);
  Future<VerifyCodeResponse> verifyCode({ required VerifyCodeRequest request }) => _repository.verifyCode(request: request);
  Future<ResetPasswordResponse> resetPassword({ required ResetPasswordRequest request }) => _repository.resetPassword(request: request);
}
