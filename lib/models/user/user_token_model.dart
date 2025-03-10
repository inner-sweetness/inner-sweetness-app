import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_token_model.freezed.dart';
part 'user_token_model.g.dart';

@freezed
abstract class UserTokenModel with _$UserTokenModel {
  const factory UserTokenModel({
    String? token,
    String? clientId,
    String? email,
  }) = _UserTokenModel;

  factory UserTokenModel.fromJson(Map<String, Object?> json) =>
      _$UserTokenModelFromJson(json);
}
