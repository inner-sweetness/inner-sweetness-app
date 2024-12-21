import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/user_service/models/response/profile_response.dart';
import 'package:medito/services/user_service/user_service.dart';

part 'upload_profile_picture_bloc.freezed.dart';

@freezed
class UploadProfilePictureEvent with _$UploadProfilePictureEvent {
  const factory UploadProfilePictureEvent.uploadProfilePicture({ required String path }) = UploadProfilePicture;
}

@freezed
class UploadProfilePictureState with _$UploadProfilePictureState {
  const factory UploadProfilePictureState.uploadProfilePictureUninitializedState() = UploadProfilePictureUninitializedState;
  const factory UploadProfilePictureState.uploadProfilePictureLoadingState() = UploadProfilePictureLoadingState;
  const factory UploadProfilePictureState.uploadProfilePictureSuccessState({ required String response }) = UploadProfilePictureSuccessState;
  const factory UploadProfilePictureState.uploadProfilePictureErrorState({@Default('') String message}) = UploadProfilePictureErrorState;
  const factory UploadProfilePictureState.uploadProfilePictureConnectionErrorState() = UploadProfilePictureConnectionErrorState;
  const factory UploadProfilePictureState.uploadProfilePictureUnauthorizedState() = UploadProfilePictureUnauthorizedState;
}

@injectable
class UploadProfilePictureBloc extends Bloc<UploadProfilePictureEvent, UploadProfilePictureState> {
  final UserServices _userServices;
  UploadProfilePictureBloc(this._userServices) : super(const UploadProfilePictureUninitializedState()) {
    on<UploadProfilePictureEvent>(_onUploadProfilePictureEvent);
  }

  void _onUploadProfilePictureEvent(UploadProfilePictureEvent event, Emitter<UploadProfilePictureState> emitter) async {
    try {
      await event.when(
        uploadProfilePicture: (path) async {
          emitter(const UploadProfilePictureLoadingState());
          final response = await _userServices.uploadProfilePicture(path: path);
          emitter(UploadProfilePictureSuccessState(response: response));
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(UploadProfilePictureErrorState(message: message));
    } catch (e) {
      emitter(UploadProfilePictureErrorState(message: e.toString()));
    }
  }
}
