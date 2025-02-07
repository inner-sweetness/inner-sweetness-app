import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetFavoriteCubit extends Cubit<bool> {
  SetFavoriteCubit() : super(false);

  void change(bool value) => emit(value);
}