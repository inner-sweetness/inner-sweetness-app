import 'package:medito/models/time/time_model.dart';
import 'package:medito/repositories/time/time_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'time_provider.g.dart';

@riverpod
Future<TimeModel> fetchTime(FetchTimeRef ref) {
  final timeRepository = ref.watch(timeRepositoryProvider);
  ref.keepAlive();

  return timeRepository.fetchTime();
}
