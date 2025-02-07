import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/views/sign_up/bloc/register_bloc/register_bloc.dart';
import 'package:medito/views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_text_field.dart';

class PersonalInfo extends StatelessWidget {
  final VoidCallback onContinue;
  const PersonalInfo({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: Navigator.of(context).maybePop,
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 80),
                    const Text(
                      'Few steps to create your account',
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
                          Expanded(
                            child: Material(
                              color: const Color(0xFF080808).withOpacity(.55),
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
                    BlocBuilder<ValidateEmailCubit, bool?>(
                      builder: (context, bool? isValidState) => LabeledTextField(
                        controller: context.read<RegisterBloc>().emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        error: isValidState == false ? 'Email is invalid' : '',
                        onFocusChange: (hasFocus, value) {
                          if (hasFocus) return;
                          context.read<ValidateEmailCubit>().validate(value);
                        },
                        onChanged: context.read<ValidateEmailCubit>().validate,
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<ValidateNameCubit, bool?>(
                      builder: (context, bool? isValidState) => LabeledTextField(
                        controller: context.read<RegisterBloc>().nameController,
                        label: 'Name',
                        hint: 'Enter your first name',
                        error: isValidState == false ? 'Name is invalid' : '',
                        onFocusChange: (hasFocus, value) {
                          if (hasFocus) return;
                          context.read<ValidateNameCubit>().validate(value);
                        },
                        onChanged: context.read<ValidateNameCubit>().validate,
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<ValidateLastnameCubit, bool?>(
                      builder: (context, bool? isValidState) => LabeledTextField(
                        controller: context.read<RegisterBloc>().lastnameController,
                        label: 'Last name',
                        hint: 'Enter your last name',
                        error: isValidState == false ? 'Lastname is invalid' : '',
                        onFocusChange: (hasFocus, value) {
                          if (hasFocus) return;
                          context.read<ValidateLastnameCubit>().validate(value);
                        },
                        onChanged: context.read<ValidateLastnameCubit>().validate,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            behavior: HitTestBehavior.opaque,
                            child: const Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFF020202),
                                    letterSpacing: -.25,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF0150FF),
                                    letterSpacing: -.25,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          BlocBuilder<ValidateEmailCubit, bool?>(
                            builder: (context, bool? emailIsValidState) => BlocBuilder<ValidateNameCubit, bool?>(
                              builder: (context, bool? nameIsValidState) => BlocBuilder<ValidateLastnameCubit, bool?>(
                                builder: (context, bool? lastnameIsValidState) => AppButton(
                                  text: 'CONTINUE',
                                  color: const Color(0xFF0150FF),
                                  radius: 56,
                                  onTap: emailIsValidState == true && nameIsValidState == true && lastnameIsValidState == true ? onContinue : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
