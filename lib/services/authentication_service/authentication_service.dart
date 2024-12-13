import 'package:injectable/injectable.dart';
import 'package:medito/services/authentication_service/authentication_repository_interface.dart';
import 'package:medito/services/authentication_service/model/request/login_request.dart';
import 'package:medito/services/authentication_service/model/request/refresh_token_request.dart';
import 'package:medito/services/authentication_service/model/request/register_request.dart';
import 'package:medito/services/authentication_service/model/response/login_response.dart';
import 'package:medito/services/authentication_service/model/response/refresh_token_response.dart';
import 'package:medito/services/authentication_service/model/response/register_response.dart';

@injectable
class AuthenticationService {
  final IAuthenticationRepository _repository;

  AuthenticationService(this._repository);

  Future<RegisterResponse> register({ required RegisterRequest request }) => _repository.register(request: request);
  Future<LoginResponse> login({ required LoginRequest request }) => _repository.login(request: request);
  Future<RefreshTokenResponse> refreshToken({ required RefreshTokenRequest request }) => _repository.refreshToken(request: request);
}
