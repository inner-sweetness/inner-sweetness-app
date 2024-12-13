import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/views/sign_up/bloc/register_bloc/register_bloc.dart';
import 'package:medito/views/sign_up/cubits/select_country_cubit/select_country_cubit.dart';
import 'package:medito/views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart';
import 'package:medito/views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart';
import 'package:medito/views/sign_up/steps/extra_info/extra_info.dart';
import 'package:medito/views/sign_up/steps/password_info/password_info.dart';
import 'package:medito/views/sign_up/steps/personal_info/personal_info.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final loading = DialogLoading();
  final registerBloc = getIt<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RegisterBloc>(create: (context) => registerBloc),
        BlocProvider<SelectCountryCubit>(create: (context) => registerBloc.selectCountryCubit),
        BlocProvider<SelectGenderCubit>(create: (context) => registerBloc.selectGenderCubit),
        BlocProvider<SignUpStepCubit>(create: (context) => getIt<SignUpStepCubit>()),
        BlocProvider<ValidateEmailCubit>(create: (context) => getIt<ValidateEmailCubit>()),
        BlocProvider<ObscurePasswordCubit>(create: (context) => getIt<ObscurePasswordCubit>()),
        BlocProvider<ObscureConfirmPasswordCubit>(create: (context) => getIt<ObscureConfirmPasswordCubit>()),
        BlocProvider<ValidateConfirmPasswordCubit>(create: (context) => getIt<ValidateConfirmPasswordCubit>()),
        BlocProvider<ValidateNameCubit>(create: (context) => getIt<ValidateNameCubit>()),
        BlocProvider<ValidateLastnameCubit>(create: (context) => getIt<ValidateLastnameCubit>()),
        BlocProvider<ValidateAgeCubit>(create: (context) => getIt<ValidateAgeCubit>()),
      ],
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, RegisterState registerState) {
          loading.hide(context);
          if (registerState is RegisterLoadingState) {
            loading.show(context);
          } else if (registerState is RegisterSuccessState) {
            AppSnackBar.showSuccessSnackBar(context, message: 'Success!');
            Navigator.pop(context);
          } else if (registerState is RegisterErrorState) {
            AppSnackBar.showErrorSnackBar(context, message: registerState.message);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        radius: .75,
                        stops: [0, 1],
                        center: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF03F480),
                          Colors.white,
                        ],
                      )
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        radius: .75,
                        stops: [0, 1],
                        center: Alignment.topRight,
                        colors: [
                          Color(0xFFFFF500),
                          Colors.white,
                        ],
                      )
                  ),
                ),
              ),
              BlocBuilder<SignUpStepCubit, SignUpStep>(
                builder: (context, SignUpStep stepState) => switch(stepState){
                  SignUpStep.principal => PersonalInfo(
                    onContinue: () => context.read<SignUpStepCubit>().change(SignUpStep.password),
                  ),
                  SignUpStep.password => PasswordInfo(
                    onContinue: () => context.read<SignUpStepCubit>().change(SignUpStep.extra),
                    onBack: () => context.read<SignUpStepCubit>().change(SignUpStep.principal),
                  ),
                  SignUpStep.extra => ExtraInfo(
                    onContinue: () => context.read<RegisterBloc>().add(const RegisterAccount()),
                    onBack: () => context.read<SignUpStepCubit>().change(SignUpStep.password),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
