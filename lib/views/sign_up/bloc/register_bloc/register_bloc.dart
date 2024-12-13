
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/model/request/register_request.dart';
import 'package:medito/services/network/auth_api_service.dart';

part 'register_bloc.freezed.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.registerAccount() = RegisterAccount;
}

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.registerUninitializedState() = RegisterUninitializedState;
  const factory RegisterState.registerLoadingState() = RegisterLoadingState;
  const factory RegisterState.registerSuccessState() = RegisterSuccessState;
  const factory RegisterState.registerErrorState({@Default('') String message}) = RegisterErrorState;
  const factory RegisterState.registerConnectionErrorState() = RegisterConnectionErrorState;
  const factory RegisterState.registerUnauthorizedState() = RegisterUnauthorizedState;
}

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final authDioApiService = AuthDioApiService();
  RegisterBloc() : super(const RegisterUninitializedState()) {
    on<RegisterEvent>(_onRegisterEvent);
  }

  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _countryController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var age = 0;

  TextEditingController get nameController => _nameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get countryController => _countryController;
  TextEditingController get genderController => _genderController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  String get name => _nameController.text.trim();
  String get lastname => _lastnameController.text.trim();
  String get country => _countryController.text.trim();
  String get gender => _genderController.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get confirmPassword => _confirmPasswordController.text.trim();

  void _onRegisterEvent(RegisterEvent event, Emitter<RegisterState> emitter) async {
    try {
      await event.when(
          registerAccount: () async {
            emitter(const RegisterLoadingState());
            final request = RegisterRequest(
              name: name,
              lastname: lastname,
              email: email,
              password: password,
              age: 24,
              country: 'USA',
              genere: 'MALE',
            );
            await authDioApiService.register(request: request);
            emitter(const RegisterSuccessState());
          },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(RegisterErrorState(message: message));
    } catch (e) {
      emitter(RegisterErrorState(message: e.toString()));
    }
  }
}
