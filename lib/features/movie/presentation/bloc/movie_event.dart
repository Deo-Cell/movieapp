import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPopularMoviesEvent extends MovieEvent {}

class GetUpcomingMoviesEvent extends MovieEvent {}

class GetNowPlayingMoviesEvent extends MovieEvent {}

class GetTopRatedMoviesEvent extends MovieEvent {}

class GetAllMoviesEvent extends MovieEvent {}


class GetAllMovieDetailsEvent extends MovieEvent {
  final int movieId;
  GetAllMovieDetailsEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class GetFilmActorEvent extends MovieEvent {
  final int movieId;
  GetFilmActorEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class GetTrailerVideoEvent extends MovieEvent {
  final int movieId;
  GetTrailerVideoEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

