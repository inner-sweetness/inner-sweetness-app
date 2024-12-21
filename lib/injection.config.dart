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

import 'di/app_config.dart' as _i16;
import 'di/app_module_config.dart' as _i35;
import 'network/dio_client.dart' as _i17;
import 'services/authentication_service/authentication_repository.dart' as _i19;
import 'services/authentication_service/authentication_repository_interface.dart'
    as _i18;
import 'services/authentication_service/authentication_service.dart' as _i23;
import 'services/contentful_services/contentful_repository.dart' as _i20;
import 'services/contentful_services/contentful_services.dart' as _i24;
import 'services/shared_preferences_service/shared_preferences_repository.dart'
    as _i4;
import 'services/shared_preferences_service/shared_preferences_service.dart'
    as _i9;
import 'services/user_service/user_repository.dart' as _i21;
import 'services/user_service/user_service.dart' as _i22;
import 'views/edit_account/logic/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i32;
import 'views/edit_account/logic/bloc/upload_profile_picture_bloc/upload_profile_picture_bloc.dart'
    as _i33;
import 'views/edit_account/logic/cubit/select_profile_image_cubit/select_profile_image_cubit.dart'
    as _i8;
import 'views/home/logic/bloc/fetch_app_bloc/fetch_app_bloc.dart' as _i25;
import 'views/home/logic/bloc/fetch_network_bloc/fetch_network_bloc.dart'
    as _i26;
import 'views/login/bloc/logic_bloc/login_bloc.dart' as _i28;
import 'views/login/bloc/reset_password_bloc/reset_password_bloc.dart' as _i30;
import 'views/login/bloc/send_code_bloc/send_code_bloc.dart' as _i31;
import 'views/login/bloc/verify_code_bloc/verify_code_bloc.dart' as _i34;
import 'views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart'
    as _i5;
import 'views/login/cubit/validate_email_cubit/validate_email_cubit.dart'
    as _i12;
import 'views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart'
    as _i27;
import 'views/sign_up/bloc/register_bloc/register_bloc.dart' as _i29;
import 'views/sign_up/cubits/select_country_cubit/select_country_cubit.dart'
    as _i6;
import 'views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart'
    as _i7;
import 'views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart'
    as _i10;
import 'views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart'
    as _i11;
import 'views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart'
    as _i13;
import 'views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart'
    as _i15;
import 'views/splash_view/bloc/validate_login_bloc/validate_login_bloc.dart'
    as _i14;

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
    gh.factory<_i8.SelectProfileImageCubit>(
        () => _i8.SelectProfileImageCubit());
    gh.factory<_i9.SharedPreferencesService>(() =>
        _i9.SharedPreferencesService(gh<_i4.ISharedPreferencesRepository>()));
    gh.factory<_i10.SignUpStepCubit>(() => _i10.SignUpStepCubit());
    gh.factory<_i11.ValidateAgeCubit>(() => _i11.ValidateAgeCubit());
    gh.factory<_i12.ValidateConfirmPasswordCubit>(
        () => _i12.ValidateConfirmPasswordCubit());
    gh.factory<_i12.ValidateEmailCubit>(() => _i12.ValidateEmailCubit());
    gh.factory<_i13.ValidateLastnameCubit>(() => _i13.ValidateLastnameCubit());
    gh.factory<_i14.ValidateLoginBloc>(
        () => _i14.ValidateLoginBloc(gh<_i9.SharedPreferencesService>()));
    gh.factory<_i15.ValidateNameCubit>(() => _i15.ValidateNameCubit());
    gh.factory<_i12.ValidateStringCubit>(() => _i12.ValidateStringCubit());
    gh.singleton<_i16.AppConfig>(
        () => _i16.AppConfig(gh<_i9.SharedPreferencesService>()));
    gh.factory<_i17.DioClient>(() => _i17.DioClient(
          gh<_i3.Dio>(),
          gh<_i9.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i18.IAuthenticationRepository>(
        () => _i19.AuthenticationRepository(
              gh<_i17.DioClient>(),
              gh<_i9.SharedPreferencesService>(),
            ));
    gh.lazySingleton<_i20.IContentfulRepository>(
        () => _i20.ContentfulRepository(gh<_i17.DioClient>()));
    gh.lazySingleton<_i21.IUserRepository>(
        () => _i21.UserRepository(gh<_i17.DioClient>()));
    gh.factory<_i22.UserServices>(
        () => _i22.UserServices(gh<_i21.IUserRepository>()));
    gh.factory<_i23.AuthenticationService>(
        () => _i23.AuthenticationService(gh<_i18.IAuthenticationRepository>()));
    gh.factory<_i24.ContentfulServices>(
        () => _i24.ContentfulServices(gh<_i20.IContentfulRepository>()));
    gh.factory<_i25.FetchAppBloc>(
        () => _i25.FetchAppBloc(gh<_i24.ContentfulServices>()));
    gh.factory<_i26.FetchNetworkBloc>(
        () => _i26.FetchNetworkBloc(gh<_i24.ContentfulServices>()));
    gh.factory<_i27.FetchProfileBloc>(
        () => _i27.FetchProfileBloc(gh<_i22.UserServices>()));
    gh.factory<_i28.LoginBloc>(
        () => _i28.LoginBloc(gh<_i23.AuthenticationService>()));
    gh.factory<_i29.RegisterBloc>(() => _i29.RegisterBloc(
          gh<_i23.AuthenticationService>(),
          gh<_i6.SelectCountryCubit>(),
          gh<_i7.SelectGenderCubit>(),
        ));
    gh.factory<_i30.ResetPasswordBloc>(
        () => _i30.ResetPasswordBloc(gh<_i23.AuthenticationService>()));
    gh.factory<_i31.SendCodeBloc>(
        () => _i31.SendCodeBloc(gh<_i23.AuthenticationService>()));
    gh.factory<_i32.UpdateProfileBloc>(
        () => _i32.UpdateProfileBloc(gh<_i22.UserServices>()));
    gh.factory<_i33.UploadProfilePictureBloc>(
        () => _i33.UploadProfilePictureBloc(gh<_i22.UserServices>()));
    gh.factory<_i34.VerifyCodeBloc>(
        () => _i34.VerifyCodeBloc(gh<_i23.AuthenticationService>()));
    return this;
  }
}

class _$AppConfigModule extends _i35.AppConfigModule {}
