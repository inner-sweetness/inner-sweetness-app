import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/bloc/verify_code_bloc/verify_code_bloc.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class VerificationCodeBottomSheet extends StatefulWidget {
  final String email;
  const VerificationCodeBottomSheet({super.key, required this.email});

  @override
  State<VerificationCodeBottomSheet> createState() => _VerificationCodeBottomSheetState();
}

class _VerificationCodeBottomSheetState extends State<VerificationCodeBottomSheet> {
  final loadingDialog = DialogLoading();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCodeBloc, VerifyCodeState>(
      listener: (context, state) {
        loadingDialog.hide(context);
        if (state is VerifyCodeLoadingState) {
          loadingDialog.show(context);
        } else if (state is VerifyCodeErrorState) {
          AppSnackBar.showErrorSnackBar(context, message: state.message);
        } else if (state is VerifyCodeSuccessState) {
          Navigator.of(context).pop(context.read<VerifyCodeBloc>().code);
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
                'Enter verification code',
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'We’ve send you a code to email@hotmail.com',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF020202),
                      letterSpacing: -.25,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        'Didn’t receive a code?',
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
                        'Resend',
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
                ],
              ),
            ),
            AppTextField(
              controller: context.read<VerifyCodeBloc>().codeController,
              hint: 'Enter your code',
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'CONTINUE',
              radius: 56,
              color: const Color(0xFF0150FF),
              onTap: () => context.read<VerifyCodeBloc>().add(VerifyCode(email: widget.email)),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showVerificationCodeBottomSheet(BuildContext context, { required String email }) async {
  return await showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => BlocProvider<VerifyCodeBloc>(
      create: (_) => getIt<VerifyCodeBloc>(),
      child: VerificationCodeBottomSheet(email: email),
    ),
  );
}
