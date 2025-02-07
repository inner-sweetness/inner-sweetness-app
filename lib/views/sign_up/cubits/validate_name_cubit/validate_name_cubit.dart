import 'package:injectable/injectable.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';

@injectable
class ValidateNameCubit extends ValidateCubit{
  @override
  void compare(String? value, String? compared) {}

  @override
  void validate(String? value) => emit(value?.isNotEmpty ?? false);
}