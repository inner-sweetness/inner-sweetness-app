import 'package:flutter/material.dart';
import 'package:medito/views/login/account_not_found_bottom_sheet.dart';
import 'package:medito/views/login/change_password_bottom_sheet.dart';
import 'package:medito/views/login/recover_password_bottom_sheet.dart';
import 'package:medito/views/login/verification_code_bottom_sheet.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_password_text_field.dart';
import 'package:medito/widgets/labeled_text_field/labeled_text_field.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loading = DialogLoading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Color(0xFFF84BA6),
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
                      Color(0xFFFF9900),
                      Colors.white,
                    ],
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 51),
                const Text(
                  'Happy to see you here!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFF020202),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 67),
                const LabeledTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                const SizedBox(height: 32),
                const LabeledPasswordTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    showRecoverPasswordBottomSheet(
                      context,
                      onContinue: () {
                        Navigator.pop(context);
                        showVerificationCodeBottomSheet(
                          context,
                          onContinue: () {
                            Navigator.pop(context);
                            showChangePasswordBottomSheet(
                              context,
                              onContinue: () {},
                            );
                          },
                        );
                      }
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF0150FF),
                      letterSpacing: -.25,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: 'LOG IN',
                  color: const Color(0xFF0150FF),
                  radius: 56,
                  onTap: () async {
                    loading.show(context);
                    await Future.delayed(const Duration(seconds: 3));
                    loading.hide(context);
                    showAccountNotFoundBottomSheet(context);
                  },
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {},
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
