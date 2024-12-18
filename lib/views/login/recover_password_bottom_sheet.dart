import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/bloc/send_code_bloc/send_code_bloc.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class RecoverPasswordBottomSheet extends StatefulWidget {
  const RecoverPasswordBottomSheet({super.key});

  @override
  State<RecoverPasswordBottomSheet> createState() => _RecoverPasswordBottomSheetState();
}

class _RecoverPasswordBottomSheetState extends State<RecoverPasswordBottomSheet> {
  final loadingDialog = DialogLoading();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendCodeBloc, SendCodeState>(
      listener: (context, state) {
        loadingDialog.hide(context);
        if (state is SendCodeLoadingState) {
          loadingDialog.show(context);
        } else if (state is SendCodeErrorState) {
          AppSnackBar.showErrorSnackBar(context, message: state.message);
        } else if (state is SendCodeSuccessState) {
          Navigator.of(context).pop(context.read<SendCodeBloc>().email);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Verify your email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: -.25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'We will send you a verification code if we find an account linked to your email.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF020202),
                  letterSpacing: -.25,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ValidateEmailCubit, bool?>(
              builder: (context, bool? isValid) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppTextField(
                    controller: context.read<SendCodeBloc>().emailController,
                    hasError: isValid == false,
                    hint: 'Enter your email',
                    onChanged: context.read<ValidateEmailCubit>().validate,
                  ),
                  if (isValid == false)
                    ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Email is invalid',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF4E64),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ValidateEmailCubit, bool?>(
              builder: (context, bool? isValid) => AppButton(
                text: 'CONTINUE',
                radius: 56,
                color: (isValid ?? false) ? const Color(0xFF0150FF) : Colors.grey,
                onTap: () {
                  if (!(isValid ?? false)) {
                    context.read<ValidateEmailCubit>().validate(context.read<SendCodeBloc>().email);
                    return;
                  }
                  context.read<SendCodeBloc>().add(const SendCode());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showRecoverPasswordBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<SendCodeBloc>(create: (context) => getIt<SendCodeBloc>()),
        BlocProvider<ValidateEmailCubit>(create: (context) => getIt<ValidateEmailCubit>()),
      ],
      child: const RecoverPasswordBottomSheet(),
    ),
  );
}
