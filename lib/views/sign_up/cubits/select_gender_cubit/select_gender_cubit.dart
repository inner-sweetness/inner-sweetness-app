import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum Genders { male, female }

extension GendersExtension on Genders {
  String get text {
    switch(this) {
      case Genders.male:
        return 'Male';
      case Genders.female:
        return 'Female';
    }
  }
}

@injectable
class SelectGenderCubit extends Cubit<Genders?>{
  SelectGenderCubit() : super(null);

  void change(Genders? value) => emit(state == value ? null : value);
}