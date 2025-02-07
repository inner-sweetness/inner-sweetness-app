import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/user_service/models/request/update_profile_request.dart';
import 'package:medito/services/user_service/models/response/profile_response.dart';
import 'package:medito/services/user_service/user_service.dart';

part 'update_profile_bloc.freezed.dart';

@freezed
class UpdateProfileEvent with _$UpdateProfileEvent {
  const factory UpdateProfileEvent.updateProfile({
    required String name,
    required String lastname,
    required String email,
    required int age,
    required String country,
    required String gender,
  }) = UpdateProfile;
}

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.updateProfileUninitializedState() = UpdateProfileUninitializedState;
  const factory UpdateProfileState.updateProfileLoadingState() = UpdateProfileLoadingState;
  const factory UpdateProfileState.updateProfileSuccessState({ required ProfileResponse response }) = UpdateProfileSuccessState;
  const factory UpdateProfileState.updateProfileErrorState({@Default('') String message}) = UpdateProfileErrorState;
  const factory UpdateProfileState.updateProfileConnectionErrorState() = UpdateProfileConnectionErrorState;
  const factory UpdateProfileState.updateProfileUnauthorizedState() = UpdateProfileUnauthorizedState;
}

@injectable
class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UserServices _userServices;
  UpdateProfileBloc(this._userServices) : super(const UpdateProfileUninitializedState()) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  void _onUpdateProfileEvent(UpdateProfileEvent event, Emitter<UpdateProfileState> emitter) async {
    try {
      await event.when(
        updateProfile: (name, lastname, email, age, country, gender) async {
          emitter(const UpdateProfileLoadingState());
          final request = UpdateProfileRequest(
            name: name,
            lastname: lastname,
            email: email,
            age: age,
            country: country,
            genere: gender,
          );
          final response = await _userServices.updateProfile(request: request);
          emitter(UpdateProfileSuccessState(response: response));
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(UpdateProfileErrorState(message: message));
    } catch (e) {
      emitter(UpdateProfileErrorState(message: e.toString()));
    }
  }
}
