import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/views/sign_up/cubits/sign_up_step_cubit/sign_up_step_cubit.dart';
import 'package:medito/views/sign_up/steps/extra_info/extra_info.dart';
import 'package:medito/views/sign_up/steps/password_info/password_info.dart';
import 'package:medito/views/sign_up/steps/personal_info/personal_info.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final appStateNotifier = ref.read(appStateProvider.notifier);
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
          switch(appState){
            SignUpStep.principal => PersonalInfo(onContinue: () => appStateNotifier.changeState(SignUpStep.password)),
            SignUpStep.password => PasswordInfo(
              onContinue: () => appStateNotifier.changeState(SignUpStep.extra),
              onBack: () => appStateNotifier.changeState(SignUpStep.principal),
            ),
            SignUpStep.extra => ExtraInfo(
              onContinue: () {},
              onBack: () => appStateNotifier.changeState(SignUpStep.password),
            ),
          },
        ],
      ),
    );
  }
}
