import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectCountryCubit extends Cubit<CountryCode?> {
  SelectCountryCubit() : super(null);

  void change(CountryCode? country) => emit(country);
}