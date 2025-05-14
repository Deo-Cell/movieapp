import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart' show Either;
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/core/params/moviedetails_params.dart';
import 'package:movieapp/features/movie/data/models/moviedetails_model.dart';
import 'package:movieapp/features/movie/data/repositories/movie_repository_impl.dart';

@injectable
class GetMoviedetailsUsecase implements Usecase<MoviedetailsModel, MoviedetailsParams> {
   final MovieRepositoryImpl movierepository;
  @override
  Future<Either<Failure, MoviedetailsModel>> call(MoviedetailsParams params) async {
  return await movierepository.getMovieDetails(params.id!);
  }

  GetMoviedetailsUsecase({required this.movierepository});
}
