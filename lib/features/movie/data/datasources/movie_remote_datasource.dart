import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/constants/api_constant.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<MoviedetailsModel> getMovieDetails(int movieId);
  Future<List<ActorModel>> getFilmActor(int movieId);
  Future<List<VideoModel>> getTrailerVideo(int movieId);
}

@LazySingleton()
class MovieRemoteDataSourceImpl implements MovieRemoteDatasource {
  final Dio dio;
  MovieRemoteDataSourceImpl(this.dio);
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await dio.get(
      ApiConstant.getNowPlayingMovie,
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        response.data['results'].map((x) => MovieModel.fromJson(x)),
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(
      ApiConstant.getPopularMovie,
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        response.data['results'].map((x) => MovieModel.fromJson(x)),
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await dio.get(
      ApiConstant.getTopRatedMovie,
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        response.data['results'].map((x) => MovieModel.fromJson(x)),
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await dio.get(
      ApiConstant.getUpcomingMovie,
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        response.data['results'].map((x) => MovieModel.fromJson(x)),
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<MoviedetailsModel> getMovieDetails(int movieId) async {
    final response = await dio.get(
      ApiConstant.getMovieDetails(movieId),
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return MoviedetailsModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Future<List<ActorModel>> getFilmActor(int movieId) async {
    final response = await dio.get(
      ApiConstant.getMovieCast(movieId),
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<ActorModel>.from(
        response.data['cast'].map((x) => ActorModel.fromJson(x)),
      );
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Future<List<VideoModel>> getTrailerVideo(int movieId) async {
    final response = await dio.get(
      ApiConstant.getMovieVideo(movieId),
      queryParameters: {"api_key": ApiConstant.apiKey},
      options: Options(
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${ApiConstant.token}"
        },
      ),
    );
    if (response.statusCode == 200) {
   
      return List<VideoModel>.from(
        response.data['results']
            .where((video) => video['type'] == 'Trailer') // Filtrer les teasers
            .map((video) =>
                VideoModel.fromJson(video)), // Convertir en VideoModel
      );
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
