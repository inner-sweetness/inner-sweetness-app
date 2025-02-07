import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the steps of the onboarding process
enum OnboardingStep { step1, step2, step3, step4, step5, completed }

// StateNotifier to manage the current onboarding step
class OnboardingNotifier extends StateNotifier<OnboardingStep> {
  OnboardingNotifier() : super(OnboardingStep.step1);

  // Method to go to the next step
  void nextStep() {
    switch (state) {
      case OnboardingStep.step1:
        state = OnboardingStep.step2;
        break;
      case OnboardingStep.step2:
        state = OnboardingStep.step3;
        break;
      case OnboardingStep.step3:
        state = OnboardingStep.step4;
        break;
      case OnboardingStep.step4:
        state = OnboardingStep.step5;
        break;
      case OnboardingStep.step5:
        state = OnboardingStep.completed;
        break;
      case OnboardingStep.completed:
        break;
    }
  }

  // Method to go to the previous step
  void previousStep() {
    switch (state) {
      case OnboardingStep.step2:
        state = OnboardingStep.step1;
        break;
      case OnboardingStep.step3:
        state = OnboardingStep.step2;
        break;
      case OnboardingStep.step4:
        state = OnboardingStep.step3;
        break;
      case OnboardingStep.step5:
        state = OnboardingStep.step4;
        break;
      default:
        break;
    }
  }

  // Reset the onboarding steps
  void reset() {
    state = OnboardingStep.step1;
  }
}

// Create a provider for OnboardingNotifier
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingStep>(
      (ref) => OnboardingNotifier(),
);
