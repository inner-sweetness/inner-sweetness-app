import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medito/models/home/shortcuts/shortcuts_model.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    required String id,
    String? title,
    String? coverUrl,
    String? subTitle,
    @Default(<ShortcutsModel>[]) List<ShortcutsModel> shortcuts,
    @Default(<HomeCarouselModel>[]) List<HomeCarouselModel> carousel,
    HomeQuoteModel? todayQuote,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}

@freezed
class HomeCarouselModel with _$HomeCarouselModel {
  const factory HomeCarouselModel({
    required String id,
    required String title,
    required String subtitle,
    required String coverUrl,
    required String? path,
    required String? type,
    List<CarouselButton>? buttons,
    @Default(false) bool showBanner,
    String? bannerColor,
    String? bannerLabelColor,
    String? bannerLabel,
  }) = _HomeCarouselModel;

  factory HomeCarouselModel.fromJson(Map<String, dynamic> json) =>
      _$HomeCarouselModelFromJson(json);
}

@freezed
class CarouselButton with _$CarouselButton {
  const factory CarouselButton({
    required String title,
    required String path,
    required String type,
  }) = _CarouselButton;

  factory CarouselButton.fromJson(Map<String, dynamic> json) =>
      _$CarouselButtonFromJson(json);
}

@freezed
class HomeQuoteModel with _$HomeQuoteModel {
  const factory HomeQuoteModel({
    required String id,
    required String quote,
    required String author,
    String? sharedBy,
  }) = _HomeQuoteModel;

  factory HomeQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$HomeQuoteModelFromJson(json);
}
