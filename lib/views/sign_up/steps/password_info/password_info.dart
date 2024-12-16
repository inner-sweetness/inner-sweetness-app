import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/views/sign_up/bloc/register_bloc/register_bloc.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_password_text_field.dart';

class PasswordInfo extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  const PasswordInfo({super.key, required this.onBack, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 51),
                  const Text(
                    'Create your own password',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF020202),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Expanded(
                          child: Material(
                            color: Color(0xFF0150FF),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Material(
                            color: Color(0xFF0150FF),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Material(
                            color: const Color(0xFF080808).withOpacity(.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ObscurePasswordCubit, bool>(
                    builder: (_, bool obscureState) => LabeledPasswordTextField(
                      controller: context.read<RegisterBloc>().passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      obscured: obscureState,
                      onSuffixTap: () => context.read<ObscurePasswordCubit>().change(!obscureState),
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<ValidateConfirmPasswordCubit, bool?>(
                    builder: (context, bool? isValidState) => BlocBuilder<ObscureConfirmPasswordCubit, bool>(
                      builder: (_, bool obscureState) => LabeledPasswordTextField(
                        controller: context.read<RegisterBloc>().confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Enter your password again',
                        error: isValidState == false ? 'Confirm password is invalid' : '',
                        obscured: obscureState,
                        onSuffixTap: () => context.read<ObscurePasswordCubit>().change(!obscureState),
                        onFocusChange: (hasFocus, value) {
                          if (hasFocus) return;
                          final password = context.read<RegisterBloc>().password;
                          final confirmPassword = context.read<RegisterBloc>().confirmPassword;
                          context.read<ValidateConfirmPasswordCubit>().compare(
                            password,
                            confirmPassword,
                          );
                        },
                        onChanged: (_) {
                          final password = context.read<RegisterBloc>().password;
                          final confirmPassword = context.read<RegisterBloc>().confirmPassword;
                          context.read<ValidateConfirmPasswordCubit>().compare(
                            password,
                            confirmPassword,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ValidateConfirmPasswordCubit, bool?>(
              builder: (context, bool? isValidState) => AppButton(
                text: 'CONTINUE',
                color: const Color(0xFF0150FF),
                radius: 56,
                onTap: isValidState == true ? onContinue : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
