import 'package:flutter/material.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  final VoidCallback onContinue;
  const ChangePasswordBottomSheet({super.key, required this.onContinue});

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
          const AppTextField(
            hint: 'New password',
            obscured: true,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              topLeft: Radius.circular(6),
            ),
            suffix: SizedBox(
              height: 24,
              width: 72,
              child: Center(
                child: Text(
                  'Show',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const AppTextField(
            hint: 'Confirm password',
            obscured: true,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            suffix: SizedBox(
              height: 24,
              width: 72,
              child: Center(
                child: Text(
                  'Show',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    color: Colors.black,
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
            onTap: onContinue,
          ),
        ],
      ),
    );
  }
}

Future<void> showChangePasswordBottomSheet(BuildContext context, { required VoidCallback onContinue }) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => ChangePasswordBottomSheet(onContinue: onContinue),
  );
}
