import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/edition_service/edition_services.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';

part 'fetch_edition_bloc.freezed.dart';

@freezed
class FetchEditionEvent with _$FetchEditionEvent {
  const factory FetchEditionEvent.fetchEdition({ required int editionId }) = FetchEdition;
}

@freezed
class FetchEditionState with _$FetchEditionState {
  const factory FetchEditionState.fetchEditionUninitializedState() = FetchEditionUninitializedState;
  const factory FetchEditionState.fetchEditionLoadingState() = FetchEditionLoadingState;
  const factory FetchEditionState.fetchEditionSuccessState({ required EditionResponse edition }) = FetchEditionSuccessState;
  const factory FetchEditionState.fetchEditionErrorState({@Default('') String message}) = FetchEditionErrorState;
  const factory FetchEditionState.fetchEditionConnectionErrorState() = FetchEditionConnectionErrorState;
  const factory FetchEditionState.fetchEditionUnauthorizedState() = FetchEditionUnauthorizedState;
}

@injectable
class FetchEditionBloc extends Bloc<FetchEditionEvent, FetchEditionState> {
  FetchEditionBloc(this._editionServices) : super(const FetchEditionUninitializedState()) {
    on<FetchEditionEvent>(_onFetchEditionEvent);
  }

  final EditionServices _editionServices;

  void _onFetchEditionEvent(FetchEditionEvent event, Emitter<FetchEditionState> emitter) async {
    try {
      await event.when(
        fetchEdition: (editionId) async {
          emitter(const FetchEditionLoadingState());
          final response = await _editionServices.getEdition(editionId: editionId);
          final edition = response.data;
          if (edition == null) {
            emitter(const FetchEditionErrorState(message: "Couldn't find any edition"));
            return;
          }
          emitter(FetchEditionSuccessState(edition: edition));
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['message'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(FetchEditionErrorState(message: message));
    } catch (e) {
      emitter(FetchEditionErrorState(message: e.toString()));
    }
  }
}
