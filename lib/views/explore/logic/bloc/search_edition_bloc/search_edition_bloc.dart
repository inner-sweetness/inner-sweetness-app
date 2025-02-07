import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/edition_service/edition_services.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/explore/logic/cubit/select_edition_category_cubit/select_edition_category_cubit.dart';

part 'search_edition_bloc.freezed.dart';

@freezed
class SearchEditionEvent with _$SearchEditionEvent {
  const factory SearchEditionEvent.searchEdition() = SearchEdition;
  const factory SearchEditionEvent.searchNext() = SearchNext;
}

@freezed
class SearchEditionState with _$SearchEditionState {
  const factory SearchEditionState.searchEditionUninitializedState() = SearchEditionUninitializedState;
  const factory SearchEditionState.searchEditionLoadingState() = SearchEditionLoadingState;
  const factory SearchEditionState.searchEditionLoadingNextState() = SearchEditionLoadingNextState;
  const factory SearchEditionState.searchEditionSuccessState() = SearchEditionSuccessState;
  const factory SearchEditionState.searchEditionErrorState({@Default('') String message}) = SearchEditionErrorState;
  const factory SearchEditionState.searchEditionConnectionErrorState() = SearchEditionConnectionErrorState;
  const factory SearchEditionState.searchEditionUnauthorizedState() = SearchEditionUnauthorizedState;
}

@injectable
class SearchEditionBloc extends Bloc<SearchEditionEvent, SearchEditionState> {
  SearchEditionBloc(this._editionServices, this.selectEditionCategoryCubit) : super(const SearchEditionUninitializedState()) {
    on<SearchEditionEvent>(_onSearchEditionEvent);
  }

  final EditionServices _editionServices;
  final SelectEditionCategoryCubit selectEditionCategoryCubit;

  final _queryController = TextEditingController();
  TextEditingController get queryController => _queryController;
  String get query => _queryController.text.trim();

  var request = EditionSearchRequest(page: 1, size: 10);

  final editions = <EditionResponse>[];

  void _onSearchEditionEvent(SearchEditionEvent event, Emitter<SearchEditionState> emitter) async {
    try {
      await event.when(
          searchEdition: () async {
            emitter(const SearchEditionLoadingState());
            request = EditionSearchRequest(
              page: 1,
              size: 10,
              category: selectEditionCategoryCubit.state,
              title: query,
            );
            final response = await _editionServices.editionSearch(request: request);
            editions..clear()..addAll([...response.data]);
            emitter(const SearchEditionSuccessState());
          },
        searchNext: () async {
          emitter(const SearchEditionLoadingNextState());
          request.page++;
          final response = await _editionServices.editionSearch(request: request);
          editions..clear()..addAll([...response.data]);
          emitter(const SearchEditionSuccessState());
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['message'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(SearchEditionErrorState(message: message));
    } catch (e) {
      emitter(SearchEditionErrorState(message: e.toString()));
    }
  }
}
