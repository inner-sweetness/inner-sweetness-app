import 'dart:ui';

enum EditionSearchCategory { mainEdition, sweetGym, article, podcast }

extension EditionSearchCategoryExtension on EditionSearchCategory {
  String get text {
    switch(this) {
      case EditionSearchCategory.mainEdition:
        return 'MAIN_EDITION';
      case EditionSearchCategory.sweetGym:
        return 'SWEET_GYM';
      case EditionSearchCategory.article:
        return 'ARTICLE';
      case EditionSearchCategory.podcast:
        return 'PODCAST';
    }
  }

  String get label {
    switch(this) {
      case EditionSearchCategory.mainEdition:
        return 'Edition';
      case EditionSearchCategory.article:
        return 'Article';
      case EditionSearchCategory.podcast:
        return 'Podcast';
      case EditionSearchCategory.sweetGym:
        return 'Sweet Gym';
    }
  }

  Color get color {
    switch(this) {
      case EditionSearchCategory.mainEdition:
        return const Color(0xFFFF9900);
      case EditionSearchCategory.article:
        return const Color(0xFF0150FF);
      case EditionSearchCategory.podcast:
        return const Color(0xFFFFF500);
      case EditionSearchCategory.sweetGym:
        return const Color(0xFF03F480);
    }
  }
}

class EditionSearchRequest {
  String? title;
  EditionSearchCategory? category;
  int page;
  int size;

  EditionSearchRequest({
    required this.page,
    required this.size,
    this.title,
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'size': size,
    'title': title,
    'category': category?.text,
  };
}