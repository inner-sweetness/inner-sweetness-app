import 'package:flutter/material.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_password_text_field.dart';

class PasswordInfo extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  const PasswordInfo({super.key, required this.onBack, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => onBack(),
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
                    const LabeledPasswordTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                    ),
                    const SizedBox(height: 32),
                    const LabeledPasswordTextField(
                      label: 'Confirm Password',
                      hint: 'Enter your password again',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                text: 'CONTINUE',
                color: const Color(0xFF0150FF),
                radius: 56,
                onTap: onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
