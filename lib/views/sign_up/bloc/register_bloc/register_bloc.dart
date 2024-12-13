
import 'package:dio/dio.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/authentication_service/authentication_service.dart';
import 'package:medito/services/authentication_service/model/request/register_request.dart';
import 'package:medito/views/sign_up/cubits/select_country_cubit/select_country_cubit.dart';
import 'package:medito/views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart';

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
  final AuthenticationService _authenticationService;
  final SelectCountryCubit selectCountryCubit;
  final SelectGenderCubit selectGenderCubit;
  RegisterBloc(this._authenticationService, this.selectCountryCubit, this.selectGenderCubit) : super(const RegisterUninitializedState()) {
    on<RegisterEvent>(_onRegisterEvent);
  }

  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();

  CountryCode? country;
  Genders? gender;

  TextEditingController get nameController => _nameController;
  TextEditingController get lastnameController => _lastnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  TextEditingController get ageController => _ageController;

  String get name => _nameController.text.trim();
  String get lastname => _lastnameController.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get confirmPassword => _confirmPasswordController.text.trim();
  int? get age => int.tryParse(_ageController.text);

  void _onRegisterEvent(RegisterEvent event, Emitter<RegisterState> emitter) async {
    try {
      await event.when(
          registerAccount: () async {
            emitter(const RegisterLoadingState());
            final countryCode = selectCountryCubit.state?.code;
            if (countryCode == null) {
              emitter(const RegisterErrorState(message: 'Country has not been selected'));
              return;
            }
            final genderValue = selectGenderCubit.state;
            if (genderValue == null) {
              emitter(const RegisterErrorState(message: 'Gender has not been selected'));
              return;
            }
            final ageValue = age;
            if (ageValue == null) {
              emitter(const RegisterErrorState(message: 'Age is invalid'));
              return;
            }
            final request = RegisterRequest(
              name: name,
              lastname: lastname,
              email: email,
              password: password,
              age: ageValue,
              country: countryCode,
              genere: genderValue.text.toUpperCase(),
            );
            await _authenticationService.register(request: request);
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
