import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/verify_code_request.dart';

part 'verify_code_bloc.freezed.dart';

@freezed
class VerifyCodeEvent with _$VerifyCodeEvent {
  const factory VerifyCodeEvent.verifyCode({ required String email }) = VerifyCode;
}

@freezed
class VerifyCodeState with _$VerifyCodeState {
  const factory VerifyCodeState.verifyCodeUninitializedState() = VerifyCodeUninitializedState;
  const factory VerifyCodeState.verifyCodeLoadingState() = VerifyCodeLoadingState;
  const factory VerifyCodeState.verifyCodeSuccessState() = VerifyCodeSuccessState;
  const factory VerifyCodeState.verifyCodeErrorState({@Default('') String message}) = VerifyCodeErrorState;
  const factory VerifyCodeState.verifyCodeConnectionErrorState() = VerifyCodeConnectionErrorState;
  const factory VerifyCodeState.verifyCodeUnauthorizedState() = VerifyCodeUnauthorizedState;
}

@injectable
class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final AuthenticationService _authenticationService;
  VerifyCodeBloc(this._authenticationService) : super(const VerifyCodeUninitializedState()) {
    on<VerifyCodeEvent>(_onVerifyCodeEvent);
  }

  final _codeController = TextEditingController();

  TextEditingController get codeController => _codeController;

  String get code => _codeController.text.trim();

  void _onVerifyCodeEvent(VerifyCodeEvent event, Emitter<VerifyCodeState> emitter) async {
    try {
      await event.when(
        verifyCode: (email) async {
          emitter(const VerifyCodeLoadingState());
          final request = VerifyCodeRequest(email: email, code: code);
          await _authenticationService.verifyCode(request: request);
          emitter(const VerifyCodeSuccessState());
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(VerifyCodeErrorState(message: message));
    } catch (e) {
      emitter(VerifyCodeErrorState(message: e.toString()));
    }
  }
}
