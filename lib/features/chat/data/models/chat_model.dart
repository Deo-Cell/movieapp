import 'package:movieapp/features/chat/domain/entities/chat_entity.dart';

class ChatResponseModel extends ChatResponseEntity {
  ChatResponseModel({
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.id,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.releaseDate,
    super.title,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  ChatResponseModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  

}

class ChatCriteriaModel {
  final String? genre;
  final String? langue;
  final String? dateMin;
  final String? dateMax;
  final int? dureeMax;
  final double? voteAverageMin;

  ChatCriteriaModel({
    this.genre,
    this.langue,
    this.dateMin,
    this.dateMax,
    this.dureeMax,
    this.voteAverageMin,
  });

  factory ChatCriteriaModel.fromJson(Map<String, dynamic> json) {
    return ChatCriteriaModel(
      genre: json['genre'],
      langue: json['langue'],
      dateMin: json['date_min'],
      dateMax: json['date_max'],
      dureeMax: json['durée_max'],
      voteAverageMin: (json['vote_average_min'] is int)
          ? (json['vote_average_min'] as int).toDouble()
          : json['vote_average_min'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genre': genre,
      'langue': langue,
      'date_min': dateMin,
      'date_max': dateMax,
      'durée_max': dureeMax,
      'vote_average_min': voteAverageMin,
    };
  }
}