import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/contentful_services/contentful_services.dart';
import 'package:medito/services/contentful_services/models/response/contentful_app_response.dart';

part 'fetch_app_bloc.freezed.dart';

extension FetchAppContextExtension on BuildContext {
  FetchAppBloc get fetchAppBloc => read<FetchAppBloc>();
}

extension FetchAppBlocExtension on FetchAppBloc {
  void fetch() => add(const FetchApp());
}

extension FetchAppStateExtension on FetchAppState {
  bool get isLoading => this is FetchAppLoadingState;
  bool get isSuccess => this is FetchAppSuccessState && (this as FetchAppSuccessState).response.data != null;
  bool get hasError => this is FetchAppErrorState;
  String get error => hasError ? (this as FetchAppErrorState).message : '';
  ContentfulAppResponse? get response => isSuccess ? (this as FetchAppSuccessState).response : null;
}

@freezed
class FetchAppEvent with _$FetchAppEvent {
  const factory FetchAppEvent.fetchApp() = FetchApp;
}

@freezed
class FetchAppState with _$FetchAppState {
  const factory FetchAppState.fetchAppUninitializedState() = FetchAppUninitializedState;
  const factory FetchAppState.fetchAppLoadingState() = FetchAppLoadingState;
  const factory FetchAppState.fetchAppSuccessState({ required ContentfulAppResponse response }) = FetchAppSuccessState;
  const factory FetchAppState.fetchAppErrorState({@Default('') String message}) = FetchAppErrorState;
  const factory FetchAppState.fetchAppConnectionErrorState() = FetchAppConnectionErrorState;
  const factory FetchAppState.fetchAppUnauthorizedState() = FetchAppUnauthorizedState;
}

@injectable
class FetchAppBloc extends Bloc<FetchAppEvent, FetchAppState> {
  FetchAppBloc(this._contentfulServices) : super(const FetchAppUninitializedState()) {
    on<FetchAppEvent>(_onFetchAppEvent);
  }

  final ContentfulServices _contentfulServices;

  void _onFetchAppEvent(FetchAppEvent event, Emitter<FetchAppState> emitter) async {
    try {
      await event.when(
        fetchApp: () async {
          emitter(const FetchAppLoadingState());
          final response = await _contentfulServices.fetchApp();
          emitter(FetchAppSuccessState(response: response));
        },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(FetchAppErrorState(message: message));
    } catch (e) {
      emitter(FetchAppErrorState(message: e.toString()));
    }
  }
}
