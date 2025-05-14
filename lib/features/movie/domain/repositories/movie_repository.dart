import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getPopularMovies();
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies();
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies();
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies();
  Future<Either<Failure, MoviedetailsModel>> getMovieDetails(int movieId);
  Future<Either<Failure, List<ActorModel>>> getFilmActor(int movieId);
  Future<Either<Failure, List<VideoModel>>> getTrailerVideo(int movieId);

}
