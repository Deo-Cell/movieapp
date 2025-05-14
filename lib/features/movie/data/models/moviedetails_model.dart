import 'package:movieapp/features/movie/domain/entities/moviedetails_entity.dart';

class MoviedetailsModel extends MoviedetailsEntity {
  MoviedetailsModel(
      {super.genres,
      super.runtime,
      super.title,
      super.backdropPath,
      super.overview,
      super.voteAverage,
      super.releaseDate});

  factory MoviedetailsModel.fromJson(Map<String, dynamic> json) {
    return MoviedetailsModel(
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => genre['name'] as String)
          .toList(),
      runtime: json['runtime'] as int,
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'] as double,
      releaseDate: json['release_date'] as String,
    );
  }

  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/w780$backdropPath'
      : 'https://via.placeholder.com/780x440?text=No+Backdrop';

  String get reldate => releaseDate!.split('-')[0];
  
  Map<String, dynamic> toJson() {
    return {
      'genres': genres,
      'runtime': runtime,
      'title': title,
      'backdroppath': backdropPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }
}
