import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/errors/exceptions.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';
import 'package:movieapp/features/movie/domain/repositories/movie_repository.dart';
import 'package:movieapp/features/movie/data/datasources/movie_remote_datasource.dart';

@LazySingleton()
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(
      {required this.remoteDatasource,
      required MovieRemoteDatasource remoteDataSource});

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies() async {
    try {
      return right(await remoteDatasource.getNowPlayingMovies());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies() async {
    try {
      return right(await remoteDatasource.getPopularMovies());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies() async {
    try {
      return right(await remoteDatasource.getTopRatedMovies());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies() async {
    try {
      return right(await remoteDatasource.getUpcomingMovies());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MoviedetailsModel>> getMovieDetails(int movieId) async {
    try {
      return right(await remoteDatasource.getMovieDetails(movieId));
    } on ServerException catch (e) {
        return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,  List<ActorModel>>> getFilmActor(int movieId) async {
      try {
      final actors = await remoteDatasource.getFilmActor(movieId);
      return right(actors);
    } on ServerException catch (e) {
        return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoModel>>> getTrailerVideo(int movieId) async {
    try {
      return right(await remoteDatasource.getTrailerVideo(movieId));
    } on ServerException catch (e) {
        return left(Failure(e.message));
    }
  }
}
