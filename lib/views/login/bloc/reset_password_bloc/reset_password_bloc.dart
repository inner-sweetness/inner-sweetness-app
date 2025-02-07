import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/reset_password_request.dart';

part 'reset_password_bloc.freezed.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.resetPassword({ required String email, required String code }) = ResetPassword;
}

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.resetPasswordUninitializedState() = ResetPasswordUninitializedState;
  const factory ResetPasswordState.resetPasswordLoadingState() = ResetPasswordLoadingState;
  const factory ResetPasswordState.resetPasswordSuccessState() = ResetPasswordSuccessState;
  const factory ResetPasswordState.resetPasswordErrorState({@Default('') String message}) = ResetPasswordErrorState;
  const factory ResetPasswordState.resetPasswordConnectionErrorState() = ResetPasswordConnectionErrorState;
  const factory ResetPasswordState.resetPasswordUnauthorizedState() = ResetPasswordUnauthorizedState;
}

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthenticationService _authenticationService;
  ResetPasswordBloc(this._authenticationService) : super(const ResetPasswordUninitializedState()) {
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  String get password => _passwordController.text.trim();
  String get confirmPassword => _confirmPasswordController.text.trim();

  void _onResetPasswordEvent(ResetPasswordEvent event, Emitter<ResetPasswordState> emitter) async {
    try {
      await event.when(
        resetPassword: (email, code) async {
          emitter(const ResetPasswordLoadingState());
          final request = ResetPasswordRequest(email: email, code: code, newPassword: password);
          await _authenticationService.resetPassword(request: request);
          emitter(const ResetPasswordSuccessState());
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(ResetPasswordErrorState(message: message));
    } catch (e) {
      emitter(ResetPasswordErrorState(message: e.toString()));
    }
  }
}
