import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/params/noparams.dart';
import 'package:movieapp/features/movie/data/models/movie_model.dart';
import 'package:movieapp/features/movie/data/repositories/movie_repository_impl.dart';

@injectable
class  GetTopRatedMoviesUsecase {
  final MovieRepositoryImpl movierepository;
  GetTopRatedMoviesUsecase({required this.movierepository});

  Future<Either<Failure, List<MovieModel>>> call(NoParams params) async {
    return await movierepository.getTopRatedMovies();
  }

}