import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectProfileImageCubit extends Cubit<String?> {
  SelectProfileImageCubit() : super(null);

  void change(String? data) => emit(data);
}