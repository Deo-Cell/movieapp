import 'package:movieapp/features/movie/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel(
      {super.iso6391,
      super.iso31661,
      super.name,
      super.key,
      super.site,
      super.size,
      super.type,
      super.official,
      super.publishedAt,
      super.id});

  VideoModel.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['key'] = key;
    data['site'] = site;
    data['size'] = size;
    data['type'] = type;
    data['official'] = official;
    data['published_at'] = publishedAt;
    data['id'] = id;
    return data;
  }

  String get trailerUrl => key != null
      ? 'https://www.youtube.com/watch?v=$key'
      : 'https://www.youtube.com/watch?v=YQHsXMglC9A&list=LRSRriXokRoS9mD4Yl-9sG3xf9KKGjNlnPj6T&index=21';
}
