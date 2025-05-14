import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/core/params/actor_params.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/data/repositories/movie_repository_impl.dart';

@injectable
class GetFilmactorUsecase implements Usecase<List<ActorModel>, ActorParams> {
  final MovieRepositoryImpl movierepository;
  @override
  Future<Either<Failure, List<ActorModel>>> call(ActorParams params) async {
    return await movierepository.getFilmActor(params.id!);
  }

  GetFilmactorUsecase({required this.movierepository});
}
