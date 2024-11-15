import 'package:medito/models/time/time_model.dart';
import 'package:medito/services/network/time_dio_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_repository.g.dart';

abstract class TimeRepository {
  Future<TimeModel> fetchTime();
}

class TimeRepositoryImpl extends TimeRepository {
  final TimeDioApiService client;

  TimeRepositoryImpl({required this.client});

  @override
  Future<TimeModel> fetchTime() async {
    try {
      var response = await client.getRequest();

      if (response == null) {
        return const TimeModel();
      }

      return TimeModel.fromJson(response);
    } catch (e) {
      return const TimeModel();
    }
  }
}

@riverpod
TimeRepositoryImpl timeRepository(
  AutoDisposeProviderRef<TimeRepositoryImpl> _,
) {
  return TimeRepositoryImpl(client: TimeDioApiService());
}
