import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:medito/views/login/cubit/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  final String email;
  final String code;
  const ChangePasswordBottomSheet({super.key, required this.email, required this.code});

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final loadingDialog = DialogLoading();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        loadingDialog.hide(context);
        if (state is ResetPasswordLoadingState) {
          loadingDialog.show(context);
        } else if (state is ResetPasswordErrorState) {
          AppSnackBar.showErrorSnackBar(context, message: state.message);
        } else if (state is ResetPasswordSuccessState) {
          Navigator.of(context).pop(true);
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
                'Change your password',
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
                'Password must be at least 6 characters long and contain a number or special character',
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
            BlocBuilder<ObscurePasswordCubit, bool>(
              builder: (context, bool obscured) => AppTextField(
                controller: context.read<ResetPasswordBloc>().passwordController,
                hint: 'New password',
                obscured: obscured,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  topLeft: Radius.circular(6),
                ),
                suffix: GestureDetector(
                  onTap: () => context.read<ObscurePasswordCubit>().change(!obscured),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    height: 24,
                    width: 72,
                    child: Center(
                      child: Text(
                        obscured ? 'Show' : 'Hide',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ObscureConfirmPasswordCubit, bool>(
              builder: (context, bool obscured) => AppTextField(
                controller: context.read<ResetPasswordBloc>().confirmPasswordController,
                hint: 'Confirm password',
                obscured: obscured,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
                suffix: GestureDetector(
                  onTap: () => context.read<ObscureConfirmPasswordCubit>().change(!obscured),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    height: 24,
                    width: 72,
                    child: Center(
                      child: Text(
                        obscured ? 'Show' : 'Hide',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'CONTINUE',
              radius: 56,
              color: const Color(0xFF0150FF),
              onTap: () => context.read<ResetPasswordBloc>().add(ResetPassword(email: widget.email, code: widget.code)),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showChangePasswordBottomSheet(BuildContext context, { required String email, required String code }) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<ResetPasswordBloc>(create: (context) => getIt<ResetPasswordBloc>()),
        BlocProvider<ObscurePasswordCubit>(create: (context) => getIt<ObscurePasswordCubit>()),
        BlocProvider<ObscureConfirmPasswordCubit>(create: (context) => getIt<ObscureConfirmPasswordCubit>()),
      ],
      child: ChangePasswordBottomSheet(email: email, code: code),
    ),
  );
}
