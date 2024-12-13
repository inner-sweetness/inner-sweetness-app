import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/constants/strings/shared_preference_constants.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_bloc.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login() = Login;
  const factory LoginEvent.logout() = Logout;
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.loginUninitializedState() = LoginUninitializedState;
  const factory LoginState.loginLoadingState() = LoginLoadingState;
  const factory LoginState.loginSuccessState() = LoginSuccessState;
  const factory LoginState.logoutLoadingState() = LogoutLoadingState;
  const factory LoginState.logoutSuccessState() = LogoutSuccessState;
  const factory LoginState.loginErrorState({@Default('') String message}) = LoginErrorState;
  const factory LoginState.loginConnectionErrorState() = LoginConnectionErrorState;
  const factory LoginState.loginUnauthorizedState() = LoginUnauthorizedState;
}

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authenticationService;
  LoginBloc(this._authenticationService) : super(const LoginUninitializedState()) {
    on<LoginEvent>(_onLoginEvent);
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  void _onLoginEvent(LoginEvent event, Emitter<LoginState> emitter) async {
    try {
      await event.when(
          login: () async {
            emitter(const LoginLoadingState());
            final request = LoginRequest(email: email, password: password);
            final response = await _authenticationService.login(request: request);
            var sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.setString(SharedPreferenceConstants.userToken, response.accessToken);
            await sharedPreferences.setString(SharedPreferenceConstants.userRefreshToken, response.refreshToken);
            emitter(const LoginSuccessState());
          },
          logout: () async {
            emitter(const LogoutLoadingState());
            var sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.clear();
            emitter(const LogoutSuccessState());
          }
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(LoginErrorState(message: message));
    } catch (e) {
      emitter(LoginErrorState(message: e.toString()));
    }
  }
}
