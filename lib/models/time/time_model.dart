import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_model.freezed.dart';
part 'time_model.g.dart';

@freezed
abstract class TimeModel with _$TimeModel {
  const factory TimeModel({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? seconds,
    int? milliSeconds,
    String? dateTime,
    String? date,
    String? time,
    String? timeZone,
    String? dayOfWeek,
    @Default(false) bool dstActive,
  }) = _TimeModel;

  factory TimeModel.fromJson(Map<String, Object?> json) =>
      _$TimeModelFromJson(json);
}
