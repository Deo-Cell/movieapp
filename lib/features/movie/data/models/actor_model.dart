import 'package:movieapp/features/movie/domain/entities/actor_entity.dart';

class ActorModel extends ActorEntity {
  ActorModel({super.name, super.profilePath});

  ActorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }

  String get posterUrl => profilePath != null
      ? 'https://image.tmdb.org/t/p/w500$profilePath'
      : 'https://via.placeholder.com/500x750?text=No+Image';

}
