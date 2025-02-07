import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/favorite_service/favorite_services.dart';
import 'package:medito/services/favorite_service/models/request/add_favorite_request.dart';

part 'add_favorite_bloc.freezed.dart';

@freezed
class AddFavoriteEvent with _$AddFavoriteEvent {
  const factory AddFavoriteEvent.addFavorite({ required int editionId }) = AddFavorite;
}

@freezed
class AddFavoriteState with _$AddFavoriteState {
  const factory AddFavoriteState.addFavoriteUninitializedState() = AddFavoriteUninitializedState;
  const factory AddFavoriteState.addFavoriteLoadingState() = AddFavoriteLoadingState;
  const factory AddFavoriteState.addFavoriteSuccessState() = AddFavoriteSuccessState;
  const factory AddFavoriteState.addFavoriteErrorState({@Default('') String message}) = AddFavoriteErrorState;
  const factory AddFavoriteState.addFavoriteConnectionErrorState() = AddFavoriteConnectionErrorState;
  const factory AddFavoriteState.addFavoriteUnauthorizedState() = AddFavoriteUnauthorizedState;
}

@injectable
class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  AddFavoriteBloc(this._favoriteServices) : super(const AddFavoriteUninitializedState()) {
    on<AddFavoriteEvent>(_onAddFavoriteEvent);
  }

  final FavoriteServices _favoriteServices;

  void _onAddFavoriteEvent(AddFavoriteEvent event, Emitter<AddFavoriteState> emitter) async {
    try {
      await event.when(
        addFavorite: (editionId) async {
          emitter(const AddFavoriteLoadingState());
          final request = AddFavoriteRequest(editionId: editionId);
          await _favoriteServices.addFavorite(request: request);
          emitter(const AddFavoriteSuccessState());
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['message'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(AddFavoriteErrorState(message: message));
    } catch (e) {
      emitter(AddFavoriteErrorState(message: e.toString()));
    }
  }
}
