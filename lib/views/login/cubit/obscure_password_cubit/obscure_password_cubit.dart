import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class ObscureCubit extends Cubit<bool> {
  ObscureCubit() : super(true);

  void change(bool value) => emit(value);
}

@injectable
class ObscurePasswordCubit extends ObscureCubit {}

@injectable
class ObscureConfirmPasswordCubit extends ObscureCubit {}
