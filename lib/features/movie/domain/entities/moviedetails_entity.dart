class MoviedetailsEntity {
  List<String>? genres;
  int? runtime;
  String? title;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? releaseDate;
  MoviedetailsEntity(
      {this.genres,
      this.runtime,
      this.title,
      this.backdropPath,
      this.overview,
      this.voteAverage,
      this.releaseDate});
}
