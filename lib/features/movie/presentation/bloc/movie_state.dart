import 'package:equatable/equatable.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieModel> movies;
  MovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class MovieDetailsLoaded extends MovieState {
  final MoviedetailsModel movie;
  MovieDetailsLoaded(this.movie);
  @override
  List<Object?> get props => [movie];
}

class MovieDetailsComplete extends MovieState {
  final MoviedetailsModel movieDetails;
  final List<ActorModel> actors;
  final List<VideoModel> trailers;

  MovieDetailsComplete({
    required this.movieDetails,
    required this.actors,
    required this.trailers,
  });
}

class FilmActorLoaded extends MovieState {
  final List<ActorModel> movie;
  FilmActorLoaded(this.movie);
  @override
  List<Object?> get props => [movie];
}

class VideoTrailerLoaded extends MovieState {
  final VideoModel movie;
  VideoTrailerLoaded(this.movie);
  @override
  List<Object?> get props => [movie];
}

class AllMoviesLoaded extends MovieState {
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> upcomingMovies;

  AllMoviesLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}

class MovieError extends MovieState {
  final String error;
  MovieError({required this.error});
  @override
  List<Object?> get props => [error];
}

class MovieDetails extends MovieState {}
