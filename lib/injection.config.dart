// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'di/app_config.dart' as _i15;
import 'di/app_module_config.dart' as _i29;
import 'network/dio_client.dart' as _i16;
import 'services/authentication_service/authentication_repository.dart' as _i18;
import 'services/authentication_service/authentication_repository_interface.dart'
    as _i17;
import 'services/authentication_service/authentication_service.dart' as _i20;
import 'services/contentful_services/contentful_repository.dart' as _i19;
import 'services/contentful_services/contentful_services.dart' as _i21;
import 'services/shared_preferences_service/shared_preferences_repository.dart'
    as _i4;
import 'services/shared_preferences_service/shared_preferences_service.dart'
    as _i8;
import 'views/home/logic/bloc/fetch_app_bloc/fetch_app_bloc.dart' as _i22;
import 'views/home/logic/bloc/fetch_network_bloc/fetch_network_bloc.dart'
    as _i23;
import 'views/login/bloc/logic_bloc/login_bloc.dart' as _i24;
import 'views/login/bloc/reset_password_bloc/reset_password_bloc.dart' as _i26;
import 'views/login/bloc/send_code_bloc/send_code_bloc.dart' as _i27;
import 'views/login/bloc/verify_code_bloc/verify_code_bloc.dart' as _i28;
import 'views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart'
    as _i5;
import 'views/login/cubit/validate_email_cubit/validate_email_cubit.dart'
    as _i11;
import 'views/sign_up/bloc/register_bloc/register_bloc.dart' as _i25;
import 'views/sign_up/cubits/select_country_cubit/select_country_cubit.dart'
    as _i6;
import 'views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart'
    as _i7;
import 'views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart' as _i9;
import 'views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart'
    as _i10;
import 'views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart'
    as _i12;
import 'views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart'
    as _i14;
import 'views/splash_view/bloc/validate_login_bloc/validate_login_bloc.dart'
    as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appConfigModule = _$AppConfigModule();
    gh.lazySingleton<_i3.Dio>(() => appConfigModule.dio);
    gh.lazySingleton<_i4.ISharedPreferencesRepository>(
        () => _i4.SharedPreferencesRepository());
    gh.factory<_i5.ObscureConfirmPasswordCubit>(
        () => _i5.ObscureConfirmPasswordCubit());
    gh.factory<_i5.ObscurePasswordCubit>(() => _i5.ObscurePasswordCubit());
    gh.factory<_i6.SelectCountryCubit>(() => _i6.SelectCountryCubit());
    gh.factory<_i7.SelectGenderCubit>(() => _i7.SelectGenderCubit());
    gh.factory<_i8.SharedPreferencesService>(() =>
        _i8.SharedPreferencesService(gh<_i4.ISharedPreferencesRepository>()));
    gh.factory<_i9.SignUpStepCubit>(() => _i9.SignUpStepCubit());
    gh.factory<_i10.ValidateAgeCubit>(() => _i10.ValidateAgeCubit());
    gh.factory<_i11.ValidateConfirmPasswordCubit>(
        () => _i11.ValidateConfirmPasswordCubit());
    gh.factory<_i11.ValidateEmailCubit>(() => _i11.ValidateEmailCubit());
    gh.factory<_i12.ValidateLastnameCubit>(() => _i12.ValidateLastnameCubit());
    gh.factory<_i13.ValidateLoginBloc>(
        () => _i13.ValidateLoginBloc(gh<_i8.SharedPreferencesService>()));
    gh.factory<_i14.ValidateNameCubit>(() => _i14.ValidateNameCubit());
    gh.factory<_i11.ValidateStringCubit>(() => _i11.ValidateStringCubit());
    gh.singleton<_i15.AppConfig>(
        () => _i15.AppConfig(gh<_i8.SharedPreferencesService>()));
    gh.factory<_i16.DioClient>(() => _i16.DioClient(
          gh<_i3.Dio>(),
          gh<_i8.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i17.IAuthenticationRepository>(
        () => _i18.AuthenticationRepository(
              gh<_i16.DioClient>(),
              gh<_i8.SharedPreferencesService>(),
            ));
    gh.lazySingleton<_i19.IContentfulRepository>(
        () => _i19.ContentfulRepository(gh<_i16.DioClient>()));
    gh.factory<_i20.AuthenticationService>(
        () => _i20.AuthenticationService(gh<_i17.IAuthenticationRepository>()));
    gh.factory<_i21.ContentfulServices>(
        () => _i21.ContentfulServices(gh<_i19.IContentfulRepository>()));
    gh.factory<_i22.FetchAppBloc>(
        () => _i22.FetchAppBloc(gh<_i21.ContentfulServices>()));
    gh.factory<_i23.FetchNetworkBloc>(
        () => _i23.FetchNetworkBloc(gh<_i21.ContentfulServices>()));
    gh.factory<_i24.LoginBloc>(
        () => _i24.LoginBloc(gh<_i20.AuthenticationService>()));
    gh.factory<_i25.RegisterBloc>(() => _i25.RegisterBloc(
          gh<_i20.AuthenticationService>(),
          gh<_i6.SelectCountryCubit>(),
          gh<_i7.SelectGenderCubit>(),
        ));
    gh.factory<_i26.ResetPasswordBloc>(
        () => _i26.ResetPasswordBloc(gh<_i20.AuthenticationService>()));
    gh.factory<_i27.SendCodeBloc>(
        () => _i27.SendCodeBloc(gh<_i20.AuthenticationService>()));
    gh.factory<_i28.VerifyCodeBloc>(
        () => _i28.VerifyCodeBloc(gh<_i20.AuthenticationService>()));
    return this;
  }
}

class _$AppConfigModule extends _i29.AppConfigModule {}
