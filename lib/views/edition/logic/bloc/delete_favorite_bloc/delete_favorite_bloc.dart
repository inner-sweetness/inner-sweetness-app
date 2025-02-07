import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/favorite_service/favorite_services.dart';

part 'delete_favorite_bloc.freezed.dart';

@freezed
class DeleteFavoriteEvent with _$DeleteFavoriteEvent {
  const factory DeleteFavoriteEvent.deleteFavorite({ required int editionId }) = DeleteFavorite;
}

@freezed
class DeleteFavoriteState with _$DeleteFavoriteState {
  const factory DeleteFavoriteState.deleteFavoriteUninitializedState() = DeleteFavoriteUninitializedState;
  const factory DeleteFavoriteState.deleteFavoriteLoadingState() = DeleteFavoriteLoadingState;
  const factory DeleteFavoriteState.deleteFavoriteSuccessState() = DeleteFavoriteSuccessState;
  const factory DeleteFavoriteState.deleteFavoriteErrorState({@Default('') String message}) = DeleteFavoriteErrorState;
  const factory DeleteFavoriteState.deleteFavoriteConnectionErrorState() = DeleteFavoriteConnectionErrorState;
  const factory DeleteFavoriteState.deleteFavoriteUnauthorizedState() = DeleteFavoriteUnauthorizedState;
}

@injectable
class DeleteFavoriteBloc extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  DeleteFavoriteBloc(this._favoriteServices) : super(const DeleteFavoriteUninitializedState()) {
    on<DeleteFavoriteEvent>(_onDeleteFavoriteEvent);
  }

  final FavoriteServices _favoriteServices;

  void _onDeleteFavoriteEvent(DeleteFavoriteEvent event, Emitter<DeleteFavoriteState> emitter) async {
    try {
      await event.when(
        deleteFavorite: (editionId) async {
          emitter(const DeleteFavoriteLoadingState());
          await _favoriteServices.deleteFavorite(editionId: editionId);
          emitter(const DeleteFavoriteSuccessState());
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['message'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(DeleteFavoriteErrorState(message: message));
    } catch (e) {
      emitter(DeleteFavoriteErrorState(message: e.toString()));
    }
  }
}
