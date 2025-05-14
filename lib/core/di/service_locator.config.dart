// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movieapp/core/common/shared_preferences.dart' as _i42;
import 'package:movieapp/core/di/register_modules.dart' as _i500;
import 'package:movieapp/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i228;
import 'package:movieapp/features/auth/data/repositories/auth_repository_impl.dart'
    as _i95;
import 'package:movieapp/features/auth/domain/use_cases/createsession_usecase.dart'
    as _i816;
import 'package:movieapp/features/auth/domain/use_cases/getrequesttoken_usecase.dart'
    as _i920;
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_bloc.dart'
    as _i713;
import 'package:movieapp/features/chat/data/datasources/chat_remote_datasource.dart'
    as _i180;
import 'package:movieapp/features/chat/data/repositories/chat_repository_impl.dart'
    as _i385;
import 'package:movieapp/features/chat/domain/use_cases/sendchat_usecase.dart'
    as _i433;
import 'package:movieapp/features/chat/presentation/bloc/chat_bloc.dart'
    as _i419;
import 'package:movieapp/features/movie/data/datasources/movie_remote_datasource.dart'
    as _i549;
import 'package:movieapp/features/movie/data/repositories/movie_repository_impl.dart'
    as _i132;
import 'package:movieapp/features/movie/domain/use_cases/get_filmactor_usecase.dart'
    as _i494;
import 'package:movieapp/features/movie/domain/use_cases/get_moviedetails_usecase.dart'
    as _i1024;
import 'package:movieapp/features/movie/domain/use_cases/get_now_playing_movies_usecase.dart'
    as _i687;
import 'package:movieapp/features/movie/domain/use_cases/get_popular_movies_usecase.dart'
    as _i454;
import 'package:movieapp/features/movie/domain/use_cases/get_top_rated_movies_usecase.dart'
    as _i152;
import 'package:movieapp/features/movie/domain/use_cases/get_trailervideo_usecase.dart'
    as _i517;
import 'package:movieapp/features/movie/domain/use_cases/get_upcoming_movies_usecase.dart'
    as _i16;
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart'
    as _i1019;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i42.SharedPreferencesStorage>(
        () => registerModule.sharedPreferencesStorage);
    gh.lazySingleton<_i549.MovieRemoteDatasource>(
        () => registerModule.movieRemoteDataSource);
    gh.lazySingleton<_i228.AuthRemoteDatasource>(
        () => _i228.AuthRemoteDatasourceImpl());
    gh.lazySingleton<_i180.ChatRemoteDataSource>(
        () => _i180.ChatRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i549.MovieRemoteDataSourceImpl>(
        () => _i549.MovieRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i95.AuthRepositoryImpl>(() => _i95.AuthRepositoryImpl(
        authRemoteDatasource: gh<_i228.AuthRemoteDatasource>()));
    gh.lazySingleton<_i132.MovieRepositoryImpl>(() => _i132.MovieRepositoryImpl(
          remoteDatasource: gh<_i549.MovieRemoteDatasource>(),
          remoteDataSource: gh<_i549.MovieRemoteDatasource>(),
        ));
    gh.lazySingleton<_i385.ChatRepositoryImpl>(
        () => _i385.ChatRepositoryImpl(gh<_i180.ChatRemoteDataSource>()));
    gh.factory<_i517.GetTrailervideoUsecase>(() => _i517.GetTrailervideoUsecase(
        movierepository: gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i1024.GetMoviedetailsUsecase>(() =>
        _i1024.GetMoviedetailsUsecase(
            movierepository: gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i494.GetFilmactorUsecase>(() => _i494.GetFilmactorUsecase(
        movierepository: gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i152.GetTopRatedMoviesUsecase>(() =>
        _i152.GetTopRatedMoviesUsecase(
            movierepository: gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i433.SendChatUsecase>(
        () => _i433.SendChatUsecase(gh<_i385.ChatRepositoryImpl>()));
    gh.factory<_i920.GetrequesttokenUsecase>(
        () => _i920.GetrequesttokenUsecase(gh<_i95.AuthRepositoryImpl>()));
    gh.factory<_i816.CreatesessionUsecase>(
        () => _i816.CreatesessionUsecase(gh<_i95.AuthRepositoryImpl>()));
    gh.factory<_i713.AuthBloc>(() => _i713.AuthBloc(
          getRequestTokenUsecase: gh<_i920.GetrequesttokenUsecase>(),
          createSessionUsecase: gh<_i816.CreatesessionUsecase>(),
        ));
    gh.factory<_i16.GetUpcomingMoviesUsecase>(
        () => _i16.GetUpcomingMoviesUsecase(gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i454.GetPopularMoviesUsecase>(
        () => _i454.GetPopularMoviesUsecase(gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i687.GetNowPlayingMoviesUsecase>(() =>
        _i687.GetNowPlayingMoviesUsecase(gh<_i132.MovieRepositoryImpl>()));
    gh.factory<_i1019.MovieBloc>(() => _i1019.MovieBloc(
          gh<_i687.GetNowPlayingMoviesUsecase>(),
          gh<_i454.GetPopularMoviesUsecase>(),
          gh<_i152.GetTopRatedMoviesUsecase>(),
          gh<_i16.GetUpcomingMoviesUsecase>(),
          gh<_i1024.GetMoviedetailsUsecase>(),
          gh<_i517.GetTrailervideoUsecase>(),
          gh<_i494.GetFilmactorUsecase>(),
        ));
    gh.factory<_i419.ChatBloc>(
        () => _i419.ChatBloc(gh<_i433.SendChatUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i500.RegisterModule {}
