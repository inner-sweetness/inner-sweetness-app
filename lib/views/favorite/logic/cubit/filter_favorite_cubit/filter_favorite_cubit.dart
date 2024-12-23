import 'package:flutter_bloc/flutter_bloc.dart';

class FilterFavoriteCubit extends Cubit<String> {
  FilterFavoriteCubit() : super('');

  void change(String query) => emit(query);
}