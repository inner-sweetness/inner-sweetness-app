import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/user_service/models/response/profile_response.dart';
import 'package:medito/services/user_service/user_service.dart';

part 'fetch_profile_bloc.freezed.dart';

extension FetchProfileBlocExtension on FetchProfileBloc {
  void fetch() => add(const FetchProfile());
}

@freezed
class FetchProfileEvent with _$FetchProfileEvent {
  const factory FetchProfileEvent.fetchProfile() = FetchProfile;
}

@freezed
class FetchProfileState with _$FetchProfileState {
  const factory FetchProfileState.loginUninitializedState() = FetchProfileUninitializedState;
  const factory FetchProfileState.loginLoadingState() = FetchProfileLoadingState;
  const factory FetchProfileState.loginSuccessState({ required ProfileResponse response }) = FetchProfileSuccessState;
  const factory FetchProfileState.loginErrorState({@Default('') String message}) = FetchProfileErrorState;
  const factory FetchProfileState.loginConnectionErrorState() = FetchProfileConnectionErrorState;
  const factory FetchProfileState.loginUnauthorizedState() = FetchProfileUnauthorizedState;
}

@injectable
class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  final UserServices _userServices;
  FetchProfileBloc(this._userServices) : super(const FetchProfileUninitializedState()) {
    on<FetchProfileEvent>(_onFetchProfileEvent);
  }

  void _onFetchProfileEvent(FetchProfileEvent event, Emitter<FetchProfileState> emitter) async {
    try {
      await event.when(
        fetchProfile: () async {
            emitter(const FetchProfileLoadingState());
            final response = await _userServices.fetchProfile();
            emitter(FetchProfileSuccessState(response: response));
          },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(FetchProfileErrorState(message: message));
    } catch (e) {
      emitter(FetchProfileErrorState(message: e.toString()));
    }
  }
}
