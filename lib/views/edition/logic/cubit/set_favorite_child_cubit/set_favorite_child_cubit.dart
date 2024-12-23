import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class SetFavoriteChildCubit extends Cubit<bool> {
  SetFavoriteChildCubit(super.initialState);

  void change(bool value) => emit(value);
}