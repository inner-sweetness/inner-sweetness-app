import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum SignUpStep { principal, password, extra }

@injectable
class SignUpStepCubit extends Cubit<SignUpStep> {
  SignUpStepCubit() : super(SignUpStep.principal);

  void change(SignUpStep step) => emit(step);
}