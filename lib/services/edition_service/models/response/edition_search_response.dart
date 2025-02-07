import 'package:medito/models/track/track_model.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';

class EditionSearchResponse {
  String? message;
  List<EditionResponse> data;
  int? total;

  EditionSearchResponse({
    this.message,
    this.data = const <EditionResponse>[],
    this.total,
  });

  factory EditionSearchResponse.fromJson(Map<String, dynamic> json) => EditionSearchResponse(
    message: json['message'],
    data: json['data'] == null ? [] : List<EditionResponse>.from(json['data']!.map((x) => EditionResponse.fromJson(x))),
    total: json['total'],
  );
}

class EditionResponse {
  int? id;
  String? title;
  String? description;
  String? duration;
  String? coverUrl;
  String? type;
  String? startAt;
  String? createdAt;
  int? parentId;
  String? url;
  bool isFavorite;
  List<EditionResponse> children;

  EditionResponse({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.coverUrl,
    this.type,
    this.startAt,
    this.createdAt,
    this.parentId,
    this.url,
    this.children = const <EditionResponse>[],
    this.isFavorite = false,
  });

  factory EditionResponse.fromJson(Map<String, dynamic> json) => EditionResponse(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    duration: json['duration'],
    coverUrl: json['coverUrl'],
    type: json['type'],
    startAt: json['startAt'],
    createdAt: json['createdAt'],
    parentId: json['parentId'],
    url: json['url'],
    isFavorite: json['isFavorite'] ?? false,
    children: json['children'] == null ? [] : List<EditionResponse>.from(json['children']!.map((x) => EditionResponse.fromJson(x))),
  );

  EditionSearchCategory? get category {
    switch(type) {
      case 'MAIN_EDITION': return EditionSearchCategory.mainEdition;
      case 'SWEET_GYM': return EditionSearchCategory.sweetGym;
      case 'PODCAST': return EditionSearchCategory.podcast;
      case 'ARTICLE': return EditionSearchCategory.article;
      default: return null;
    }
  }

  DateTime get createdAtDate => DateTime.tryParse(createdAt ?? '') ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'duration': duration,
    'coverUrl': coverUrl,
    'type': type,
    'startAt': startAt,
    'createdAt': createdAt,
    'parentId': parentId,
    'url': url,
    'isFavorite': isFavorite,
    'children': children.map((e) => e.toJson()),
  };

  TrackModel toTrackModel() => TrackModel(
    id: '$parentId',
    title: title ?? '',
    description: description ?? '',
    coverUrl: coverUrl ?? '',
    isPublished: true,
    hasBackgroundSound: false,
    audio: <TrackAudioModel>[
      TrackAudioModel(
        guideName: description ?? '',
        files: <TrackFilesModel>[
          TrackFilesModel(
            id: '$id',
            path: url ?? '',
            duration: int.tryParse(duration ?? '') ?? 0,
          ),
        ],
      )
    ],
  );
}