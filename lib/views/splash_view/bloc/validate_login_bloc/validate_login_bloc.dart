import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_keys.dart';
import 'package:medito/services/shared_preferences_service/shared_preferences_service.dart';

part 'validate_login_bloc.freezed.dart';

@freezed
class ValidateLoginEvent with _$ValidateLoginEvent {
  const factory ValidateLoginEvent.validateLogin() = ValidateLogin;
}

@freezed
class ValidateLoginState with _$ValidateLoginState {
  const factory ValidateLoginState.validateLoginUninitializedState() = ValidateLoginUninitializedState;
  const factory ValidateLoginState.validateLoginLoadingState() = ValidateLoginLoadingState;
  const factory ValidateLoginState.validateLoginSuccessState({ required bool valid }) = ValidateLoginSuccessState;
  const factory ValidateLoginState.validateLoginErrorState({@Default('') String message}) = ValidateLoginErrorState;
  const factory ValidateLoginState.validateLoginConnectionErrorState() = ValidateLoginConnectionErrorState;
  const factory ValidateLoginState.validateLoginUnauthorizedState() = ValidateLoginUnauthorizedState;
}

@injectable
class ValidateLoginBloc extends Bloc<ValidateLoginEvent, ValidateLoginState> {
  final SharedPreferencesService _sharedPreferencesService;
  ValidateLoginBloc(this._sharedPreferencesService) : super(const ValidateLoginUninitializedState()) {
    on<ValidateLoginEvent>(_onValidateLoginEvent);
  }

  void _onValidateLoginEvent(ValidateLoginEvent event, Emitter<ValidateLoginState> emitter) async {
    try {
      await event.when(
          validateLogin: () async {
            emitter(const ValidateLoginLoadingState());
            await Future.delayed(const Duration(seconds: 3));
            final token = _sharedPreferencesService.getString(SharedPreferencesKeys.tokenKey);
            emitter(ValidateLoginSuccessState(valid: token.isNotEmpty));
          },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(ValidateLoginErrorState(message: message));
    } catch (e) {
      emitter(ValidateLoginErrorState(message: e.toString()));
    }
  }
}
