import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class ValidateCubit extends Cubit<bool?> {
  ValidateCubit() : super(null);

  void validate(String? value);
  void compare(String? value, String? compared);
}

@injectable
class ValidateStringCubit extends ValidateCubit {
  @override
  void compare(String? value, String? compared) {}

  @override
  void validate(String? value) {
    if (value == null) {
      emit(false);
      return;
    }
    emit(value.isNotEmpty);
  }
}

@injectable
class ValidateEmailCubit extends ValidateCubit {
  @override
  void validate(String? value) {
    if (value == null) {
      emit(false);
      return;
    }
    final emailRegex =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final emailIsValid = emailRegex.hasMatch(value);
    emit(emailIsValid);
  }

  @override
  void compare(String? value, String? compared) {}
}

@injectable
class ValidateConfirmPasswordCubit extends ValidateCubit {
  @override
  void validate(String? value) {}

  @override
  void compare(String? value, String? compared) => emit(value == compared);
}