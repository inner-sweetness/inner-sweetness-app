// Define an enum for different states
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SignUpStep { principal, password, extra }

// StateNotifier to manage the SignUpStep
class SignUpStepNotifier extends StateNotifier<SignUpStep> {
  SignUpStepNotifier() : super(SignUpStep.principal);

  void changeState(SignUpStep newState) {
    state = newState;
  }
}

// StateNotifierProvider to expose the SignUpStepNotifier
final appStateProvider = StateNotifierProvider<SignUpStepNotifier, SignUpStep>(
      (ref) => SignUpStepNotifier(),
);