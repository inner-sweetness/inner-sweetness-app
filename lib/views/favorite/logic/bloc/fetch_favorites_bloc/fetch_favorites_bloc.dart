import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/favorite_service/favorite_services.dart';
import 'package:medito/services/favorite_service/models/response/fetch_favorite_response.dart';

part 'fetch_favorites_bloc.freezed.dart';

@freezed
class FetchFavoritesEvent with _$FetchFavoritesEvent {
  const factory FetchFavoritesEvent.fetchFavorites() = FetchFavorites;
}

@freezed
class FetchFavoritesState with _$FetchFavoritesState {
  const factory FetchFavoritesState.fetchFavoritesUninitializedState() = FetchFavoritesUninitializedState;
  const factory FetchFavoritesState.fetchFavoritesLoadingState() = FetchFavoritesLoadingState;
  const factory FetchFavoritesState.fetchFavoritesSuccessState({ required List<FavoriteResponse> items }) = FetchFavoritesSuccessState;
  const factory FetchFavoritesState.fetchFavoritesErrorState({@Default('') String message}) = FetchFavoritesErrorState;
  const factory FetchFavoritesState.fetchFavoritesConnectionErrorState() = FetchFavoritesConnectionErrorState;
  const factory FetchFavoritesState.fetchFavoritesUnauthorizedState() = FetchFavoritesUnauthorizedState;
}

@injectable
class FetchFavoritesBloc extends Bloc<FetchFavoritesEvent, FetchFavoritesState> {
  FetchFavoritesBloc(this._favoriteServices) : super(const FetchFavoritesUninitializedState()) {
    on<FetchFavoritesEvent>(_onFetchFavoritesEvent);
  }

  final FavoriteServices _favoriteServices;

  void _onFetchFavoritesEvent(FetchFavoritesEvent event, Emitter<FetchFavoritesState> emitter) async {
    try {
      await event.when(
        fetchFavorites: () async {
          emitter(const FetchFavoritesLoadingState());
          final response = await _favoriteServices.fetchFavorites();
          emitter(FetchFavoritesSuccessState(items: response.data));
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['message'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(FetchFavoritesErrorState(message: message));
    } catch (e) {
      emitter(FetchFavoritesErrorState(message: e.toString()));
    }
  }
}
