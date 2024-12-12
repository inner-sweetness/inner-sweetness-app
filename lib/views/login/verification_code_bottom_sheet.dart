import 'package:flutter/material.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

class VerificationCodeBottomSheet extends StatelessWidget {
  final VoidCallback onContinue;
  const VerificationCodeBottomSheet({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const AppTextField(
            hint: 'Enter your code',
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'CONTINUE',
            radius: 56,
            color: const Color(0xFF0150FF),
            onTap: onContinue,
          ),
        ],
      ),
    );
  }
}

Future<void> showVerificationCodeBottomSheet(BuildContext context, { required VoidCallback onContinue }) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => VerificationCodeBottomSheet(onContinue: onContinue),
  );
}
