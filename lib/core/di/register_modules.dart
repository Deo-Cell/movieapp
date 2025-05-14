import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/constants/api_constant.dart';
import 'package:movieapp/core/common/shared_preferences.dart';
import 'package:movieapp/features/movie/data/datasources/movie_remote_datasource.dart';


@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

  @lazySingleton
  SharedPreferencesStorage get sharedPreferencesStorage => SharedPreferencesStorage();

  @lazySingleton
  MovieRemoteDatasource get movieRemoteDataSource => 
    MovieRemoteDataSourceImpl(dio);
  
}