import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';

@injectable
class SelectEditionCategoryCubit extends Cubit<EditionSearchCategory?> {
  SelectEditionCategoryCubit() : super(null);

  void change(EditionSearchCategory? category) => emit(category == state ? null : category);
}