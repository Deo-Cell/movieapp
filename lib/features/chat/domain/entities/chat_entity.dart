
class ChatResponseEntity {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  ChatResponseEntity({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://via.placeholder.com/500x750?text=No+Image';

  // Générer l'URL du backdrop (image de fond)
  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/w780$backdropPath'
      : 'https://via.placeholder.com/780x440?text=No+Backdrop';

  // Méthode utilitaire pour l'URL d'image avec la taille spécifiée
  String imageUrl(String size) => posterPath != null
      ? 'https://image.tmdb.org/t/p/$size$posterPath'
      : 'https://via.placeholder.com/500x750?text=No+Image';


}