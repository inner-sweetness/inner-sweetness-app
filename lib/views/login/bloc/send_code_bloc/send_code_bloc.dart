import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/send_code_request.dart';

part 'send_code_bloc.freezed.dart';

@freezed
class SendCodeEvent with _$SendCodeEvent {
  const factory SendCodeEvent.sendCode() = SendCode;
}

@freezed
class SendCodeState with _$SendCodeState {
  const factory SendCodeState.sendCodeUninitializedState() = SendCodeUninitializedState;
  const factory SendCodeState.sendCodeLoadingState() = SendCodeLoadingState;
  const factory SendCodeState.sendCodeSuccessState() = SendCodeSuccessState;
  const factory SendCodeState.sendCodeErrorState({@Default('') String message}) = SendCodeErrorState;
  const factory SendCodeState.sendCodeConnectionErrorState() = SendCodeConnectionErrorState;
  const factory SendCodeState.sendCodeUnauthorizedState() = SendCodeUnauthorizedState;
}

@injectable
class SendCodeBloc extends Bloc<SendCodeEvent, SendCodeState> {
  final AuthenticationService _authenticationService;
  SendCodeBloc(this._authenticationService) : super(const SendCodeUninitializedState()) {
    on<SendCodeEvent>(_onSendCodeEvent);
  }

  final _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  String get email => _emailController.text.trim();

  void _onSendCodeEvent(SendCodeEvent event, Emitter<SendCodeState> emitter) async {
    try {
      await event.when(
          sendCode: () async {
            emitter(const SendCodeLoadingState());
            final request = SendCodeRequest(email: email);
            await _authenticationService.sendCode(request: request);
            emitter(const SendCodeSuccessState());
          },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(SendCodeErrorState(message: message));
    } catch (e) {
      emitter(SendCodeErrorState(message: e.toString()));
    }
  }
}
