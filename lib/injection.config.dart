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

import 'di/app_config.dart' as _i18;
import 'di/app_module_config.dart' as _i46;
import 'network/dio_client.dart' as _i19;
import 'services/authentication_service/authentication_repository.dart' as _i21;
import 'services/authentication_service/authentication_repository_interface.dart'
    as _i20;
import 'services/authentication_service/authentication_service.dart' as _i27;
import 'services/contentful_service/contentful_repository.dart' as _i22;
import 'services/contentful_service/contentful_services.dart' as _i28;
import 'services/edition_service/edition_repository.dart' as _i23;
import 'services/edition_service/edition_services.dart' as _i29;
import 'services/favorite_service/favorite_repository.dart' as _i24;
import 'services/favorite_service/favorite_services.dart' as _i30;
import 'services/shared_preferences_service/shared_preferences_repository.dart'
    as _i4;
import 'services/shared_preferences_service/shared_preferences_service.dart'
    as _i11;
import 'services/user_service/user_repository.dart' as _i25;
import 'services/user_service/user_service.dart' as _i26;
import 'views/edit_account/logic/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i41;
import 'views/edit_account/logic/bloc/upload_profile_picture_bloc/upload_profile_picture_bloc.dart'
    as _i42;
import 'views/edit_account/logic/cubit/select_profile_image_cubit/select_profile_image_cubit.dart'
    as _i9;
import 'views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart'
    as _i44;
import 'views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart'
    as _i45;
import 'views/edition/logic/bloc/fetch_edition_bloc/fetch_edition_bloc.dart'
    as _i32;
import 'views/edition/logic/cubit/set_favorite_cubit/set_favorite_cubit.dart'
    as _i10;
import 'views/explore/logic/bloc/search_edition_bloc/search_edition_bloc.dart'
    as _i39;
import 'views/explore/logic/cubit/select_edition_category_cubit/select_edition_category_cubit.dart'
    as _i7;
import 'views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart'
    as _i33;
import 'views/home/logic/bloc/fetch_app_bloc/fetch_app_bloc.dart' as _i31;
import 'views/home/logic/bloc/fetch_network_bloc/fetch_network_bloc.dart'
    as _i34;
import 'views/login/bloc/logic_bloc/login_bloc.dart' as _i36;
import 'views/login/bloc/reset_password_bloc/reset_password_bloc.dart' as _i38;
import 'views/login/bloc/send_code_bloc/send_code_bloc.dart' as _i40;
import 'views/login/bloc/verify_code_bloc/verify_code_bloc.dart' as _i43;
import 'views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart'
    as _i5;
import 'views/login/cubit/validate_email_cubit/validate_email_cubit.dart'
    as _i14;
import 'views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart'
    as _i35;
import 'views/sign_up/bloc/register_bloc/register_bloc.dart' as _i37;
import 'views/sign_up/cubits/select_country_cubit/select_country_cubit.dart'
    as _i6;
import 'views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart'
    as _i8;
import 'views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart'
    as _i12;
import 'views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart'
    as _i13;
import 'views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart'
    as _i15;
import 'views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart'
    as _i17;
import 'views/splash_view/bloc/validate_login_bloc/validate_login_bloc.dart'
    as _i16;

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
    gh.factory<_i7.SelectEditionCategoryCubit>(
        () => _i7.SelectEditionCategoryCubit());
    gh.factory<_i8.SelectGenderCubit>(() => _i8.SelectGenderCubit());
    gh.factory<_i9.SelectProfileImageCubit>(
        () => _i9.SelectProfileImageCubit());
    gh.factory<_i10.SetFavoriteCubit>(() => _i10.SetFavoriteCubit());
    gh.factory<_i11.SharedPreferencesService>(() =>
        _i11.SharedPreferencesService(gh<_i4.ISharedPreferencesRepository>()));
    gh.factory<_i12.SignUpStepCubit>(() => _i12.SignUpStepCubit());
    gh.factory<_i13.ValidateAgeCubit>(() => _i13.ValidateAgeCubit());
    gh.factory<_i14.ValidateConfirmPasswordCubit>(
        () => _i14.ValidateConfirmPasswordCubit());
    gh.factory<_i14.ValidateEmailCubit>(() => _i14.ValidateEmailCubit());
    gh.factory<_i15.ValidateLastnameCubit>(() => _i15.ValidateLastnameCubit());
    gh.factory<_i16.ValidateLoginBloc>(
        () => _i16.ValidateLoginBloc(gh<_i11.SharedPreferencesService>()));
    gh.factory<_i17.ValidateNameCubit>(() => _i17.ValidateNameCubit());
    gh.factory<_i14.ValidateStringCubit>(() => _i14.ValidateStringCubit());
    gh.singleton<_i18.AppConfig>(
        () => _i18.AppConfig(gh<_i11.SharedPreferencesService>()));
    gh.factory<_i19.DioClient>(() => _i19.DioClient(
          gh<_i3.Dio>(),
          gh<_i11.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i20.IAuthenticationRepository>(
        () => _i21.AuthenticationRepository(
              gh<_i19.DioClient>(),
              gh<_i11.SharedPreferencesService>(),
            ));
    gh.lazySingleton<_i22.IContentfulRepository>(
        () => _i22.ContentfulRepository(gh<_i19.DioClient>()));
    gh.lazySingleton<_i23.IEditionRepository>(
        () => _i23.EditionRepository(gh<_i19.DioClient>()));
    gh.lazySingleton<_i24.IFavoriteRepository>(
        () => _i24.FavoriteRepository(gh<_i19.DioClient>()));
    gh.lazySingleton<_i25.IUserRepository>(
        () => _i25.UserRepository(gh<_i19.DioClient>()));
    gh.factory<_i26.UserServices>(
        () => _i26.UserServices(gh<_i25.IUserRepository>()));
    gh.factory<_i27.AuthenticationService>(
        () => _i27.AuthenticationService(gh<_i20.IAuthenticationRepository>()));
    gh.factory<_i28.ContentfulServices>(
        () => _i28.ContentfulServices(gh<_i22.IContentfulRepository>()));
    gh.factory<_i29.EditionServices>(
        () => _i29.EditionServices(gh<_i23.IEditionRepository>()));
    gh.factory<_i30.FavoriteServices>(
        () => _i30.FavoriteServices(gh<_i24.IFavoriteRepository>()));
    gh.factory<_i31.FetchAppBloc>(
        () => _i31.FetchAppBloc(gh<_i28.ContentfulServices>()));
    gh.factory<_i32.FetchEditionBloc>(
        () => _i32.FetchEditionBloc(gh<_i29.EditionServices>()));
    gh.factory<_i33.FetchFavoritesBloc>(
        () => _i33.FetchFavoritesBloc(gh<_i30.FavoriteServices>()));
    gh.factory<_i34.FetchNetworkBloc>(
        () => _i34.FetchNetworkBloc(gh<_i28.ContentfulServices>()));
    gh.factory<_i35.FetchProfileBloc>(
        () => _i35.FetchProfileBloc(gh<_i26.UserServices>()));
    gh.factory<_i36.LoginBloc>(
        () => _i36.LoginBloc(gh<_i27.AuthenticationService>()));
    gh.factory<_i37.RegisterBloc>(() => _i37.RegisterBloc(
          gh<_i27.AuthenticationService>(),
          gh<_i6.SelectCountryCubit>(),
          gh<_i8.SelectGenderCubit>(),
        ));
    gh.factory<_i38.ResetPasswordBloc>(
        () => _i38.ResetPasswordBloc(gh<_i27.AuthenticationService>()));
    gh.factory<_i39.SearchEditionBloc>(() => _i39.SearchEditionBloc(
          gh<_i29.EditionServices>(),
          gh<_i7.SelectEditionCategoryCubit>(),
        ));
    gh.factory<_i40.SendCodeBloc>(
        () => _i40.SendCodeBloc(gh<_i27.AuthenticationService>()));
    gh.factory<_i41.UpdateProfileBloc>(
        () => _i41.UpdateProfileBloc(gh<_i26.UserServices>()));
    gh.factory<_i42.UploadProfilePictureBloc>(
        () => _i42.UploadProfilePictureBloc(gh<_i26.UserServices>()));
    gh.factory<_i43.VerifyCodeBloc>(
        () => _i43.VerifyCodeBloc(gh<_i27.AuthenticationService>()));
    gh.factory<_i44.AddFavoriteBloc>(
        () => _i44.AddFavoriteBloc(gh<_i30.FavoriteServices>()));
    gh.factory<_i45.DeleteFavoriteBloc>(
        () => _i45.DeleteFavoriteBloc(gh<_i30.FavoriteServices>()));
    return this;
  }
}

class _$AppConfigModule extends _i46.AppConfigModule {}
