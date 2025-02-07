import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medito/services/contentful_service/contentful_services.dart';
import 'package:medito/services/contentful_service/models/response/contentful_network_response.dart';

part 'fetch_network_bloc.freezed.dart';

extension FetchNetworkContextExtension on BuildContext {
  FetchNetworkBloc get fetchNetworkBloc => read<FetchNetworkBloc>();
}

extension FetchNetworkBlocExtension on FetchNetworkBloc {
  void fetch() => add(const FetchNetwork());
}

extension FetchNetworkStateExtension on FetchNetworkState {
  bool get isLoading => this is FetchNetworkLoadingState;
  bool get isEmpty => this is FetchNetworkSuccessState && (this as FetchNetworkSuccessState).response.data.isEmpty;
  bool get isSuccess => this is FetchNetworkSuccessState && (this as FetchNetworkSuccessState).response.data.isNotEmpty;
  List<NetworkResponse> get networks => isSuccess ? (this as FetchNetworkSuccessState).response.data : [];
  bool get hasError => this is FetchNetworkErrorState;
  String get error => hasError ? (this as FetchNetworkErrorState).message : '';
}

@freezed
class FetchNetworkEvent with _$FetchNetworkEvent {
  const factory FetchNetworkEvent.fetchNetwork() = FetchNetwork;
}

@freezed
class FetchNetworkState with _$FetchNetworkState {
  const factory FetchNetworkState.fetchNetworkUninitializedState() = FetchNetworkUninitializedState;
  const factory FetchNetworkState.fetchNetworkLoadingState() = FetchNetworkLoadingState;
  const factory FetchNetworkState.fetchNetworkSuccessState({ required ContentfulNetworksResponse response }) = FetchNetworkSuccessState;
  const factory FetchNetworkState.fetchNetworkErrorState({@Default('') String message}) = FetchNetworkErrorState;
  const factory FetchNetworkState.fetchNetworkConnectionErrorState() = FetchNetworkConnectionErrorState;
  const factory FetchNetworkState.fetchNetworkUnauthorizedState() = FetchNetworkUnauthorizedState;
}

@injectable
class FetchNetworkBloc extends Bloc<FetchNetworkEvent, FetchNetworkState> {
  FetchNetworkBloc(this._contentfulServices) : super(const FetchNetworkUninitializedState()) {
    on<FetchNetworkEvent>(_onFetchNetworkEvent);
  }

  final ContentfulServices _contentfulServices;

  void _onFetchNetworkEvent(FetchNetworkEvent event, Emitter<FetchNetworkState> emitter) async {
    try {
      await event.when(
          fetchNetwork: () async {
            emitter(const FetchNetworkLoadingState());
            final response = await _contentfulServices.fetchNetworks();
            emitter(FetchNetworkSuccessState(response: response));
          },
      );
    } on DioException catch(e) {
      var data = e.response?.data is Map ? e.response?.data as Map : null;
      var message = data?['detail'] as String?;
      message ??= e.response?.data is String? ? (e.response?.data as String?) : null;
      message ??= e.response?.statusMessage ?? '';
      emitter(FetchNetworkErrorState(message: message));
    } catch (e) {
      emitter(FetchNetworkErrorState(message: e.toString()));
    }
  }
}
