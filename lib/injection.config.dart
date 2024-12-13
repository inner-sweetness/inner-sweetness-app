// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'views/login/bloc/login_bloc.dart' as _i3;
import 'views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart'
    as _i4;
import 'views/login/cubit/validate_email_cubit/validate_email_cubit.dart'
    as _i7;
import 'views/sign_up/bloc/register_bloc/register_bloc.dart' as _i5;
import 'views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart' as _i6;

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
    gh.factory<_i3.LoginBloc>(() => _i3.LoginBloc());
    gh.factory<_i4.ObscureConfirmPasswordCubit>(
        () => _i4.ObscureConfirmPasswordCubit());
    gh.factory<_i4.ObscurePasswordCubit>(() => _i4.ObscurePasswordCubit());
    gh.factory<_i5.RegisterBloc>(() => _i5.RegisterBloc());
    gh.factory<_i6.SignUpStepCubit>(() => _i6.SignUpStepCubit());
    gh.factory<_i7.ValidateConfirmPasswordCubit>(
        () => _i7.ValidateConfirmPasswordCubit());
    gh.factory<_i7.ValidateEmailCubit>(() => _i7.ValidateEmailCubit());
    return this;
  }
}
