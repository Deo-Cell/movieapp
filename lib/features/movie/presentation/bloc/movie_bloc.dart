import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/params/noparams.dart';
import 'package:movieapp/core/params/actor_params.dart';
import 'package:movieapp/core/params/video_params.dart';
import 'package:movieapp/core/params/moviedetails_params.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_event.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_state.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_filmactor_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_trailervideo_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_moviedetails_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_popular_movies_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_upcoming_movies_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_top_rated_movies_usecase.dart';
import 'package:movieapp/features/movie/domain/use_cases/get_now_playing_movies_usecase.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMoviesUsecase getNowPlayingMoviesUsecase;
  final GetPopularMoviesUsecase getPopularMoviesUsecase;
  final GetTopRatedMoviesUsecase getTopRatedMoviesUsecase;
  final GetUpcomingMoviesUsecase getUpcomingMoviesUsecase;
  final GetMoviedetailsUsecase getMoviedetailsUsecase;
  final GetTrailervideoUsecase getTrailervideoUsecase;
  final GetFilmactorUsecase getFilmactorUsecase;
  MovieBloc(
      this.getNowPlayingMoviesUsecase,
      this.getPopularMoviesUsecase,
      this.getTopRatedMoviesUsecase,
      this.getUpcomingMoviesUsecase,
      this.getMoviedetailsUsecase,
      this.getTrailervideoUsecase,
      this.getFilmactorUsecase)
      : super(MovieInitial()) {
    on<GetAllMoviesEvent>(_onGetAllMovies);
    on<GetNowPlayingMoviesEvent>(_onGetNowPlayingMovies);
    on<GetPopularMoviesEvent>(_onGetPopularMovies);
    on<GetTopRatedMoviesEvent>(_onGetTopRatedMovies);
    on<GetUpcomingMoviesEvent>(_onGetUpcomingMovies);
    on<GetAllMovieDetailsEvent>(_onGetAllMoviesDetails);
  
  }

   Future<void> _onGetAllMoviesDetails(
      GetAllMovieDetailsEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    try {
      
      final results = await Future.wait([
        getMoviedetailsUsecase.call(MoviedetailsParams(id: event.movieId)),
        getTrailervideoUsecase.call(VideoParams(id: event.movieId)),
        getFilmactorUsecase.call(ActorParams(id: event.movieId)),

      ]);

      final hasError = results.any((result) => result.isLeft());
      if (hasError) {
        final errorMessage = results
            .firstWhere((result) => result.isLeft())
            .fold((failure) => failure.message, (_) => 'Unknown error');
        emit(MovieError(error: errorMessage));
        return;
      }

      final movieDetails =
          (results[0] as Right<Failure, MoviedetailsModel>).value;
      final filmActors =
          (results[2] as Right<Failure, List<ActorModel>>).value;
      final videoTrailers =
          (results[1] as Right<Failure, List<VideoModel>>).value;
    

      // Émission d'un état avec tous les films
      emit(MovieDetailsComplete(
        movieDetails: movieDetails,
        actors: filmActors,
        trailers: videoTrailers,
    
      ));
    } catch (e) {
      emit(MovieError(error: e.toString()));
    }
  }

  Future<void> _onGetAllMovies(
      GetAllMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    try {
      
      final results = await Future.wait([
        getNowPlayingMoviesUsecase.call(NoParams()),
        getPopularMoviesUsecase.call(NoParams()),
        getTopRatedMoviesUsecase.call(NoParams()),
        getUpcomingMoviesUsecase.call(NoParams()),
      ]);

      final hasError = results.any((result) => result.isLeft());
      if (hasError) {
        final errorMessage = results
            .firstWhere((result) => result.isLeft())
            .fold((failure) => failure.message, (_) => 'Unknown error');
        emit(MovieError(error: errorMessage));
        return;
      }

      final nowPlayingMovies =
          (results[0] as Right<Failure, List<MovieModel>>).value;
      final popularMovies =
          (results[1] as Right<Failure, List<MovieModel>>).value;
      final topRatedMovies =
          (results[2] as Right<Failure, List<MovieModel>>).value;
      final upcomingMovies =
          (results[3] as Right<Failure, List<MovieModel>>).value;

      // Émission d'un état avec tous les films
      emit(AllMoviesLoaded(
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
        topRatedMovies: topRatedMovies,
        upcomingMovies: upcomingMovies,
      ));
    } catch (e) {
      emit(MovieError(error: e.toString()));
    }
  }

 

  Future<void> _onGetNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await getNowPlayingMoviesUsecase.call(NoParams());
    result.fold(
      (failure) {
        print(failure.message);
        emit(MovieError(error: failure.message));
      },
      (movies) {
        print("length: ${movies.length}");

        emit(MovieLoaded(movies));
      },
    );
  }

  Future<void> _onGetPopularMovies(
      GetPopularMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await getPopularMoviesUsecase.call(NoParams());
    result.fold(
      (failure) => emit(MovieError(error: failure.message)),
      (movies) => emit(MovieLoaded(movies)),
    );
  }

  Future<void> _onGetTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await getTopRatedMoviesUsecase.call(NoParams());
    result.fold(
      (failure) => emit(MovieError(error: failure.message)),
      (movies) => emit(MovieLoaded(movies)),
    );
  }

  Future<void> _onGetUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await getUpcomingMoviesUsecase.call(NoParams());
    result.fold((failure) => emit(MovieError(error: failure.message)),
        (movies) {
      emit(MovieLoaded(movies));
    });
  }

 
}
