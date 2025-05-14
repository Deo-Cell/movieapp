import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/core/params/video_params.dart';
import 'package:movieapp/features/movie/data/models/video_model.dart';
import 'package:movieapp/features/movie/data/repositories/movie_repository_impl.dart';

@injectable
class GetTrailervideoUsecase implements Usecase<List<VideoModel>, VideoParams> {
  final MovieRepositoryImpl movierepository;
  @override
  Future<Either<Failure, List<VideoModel>>> call(VideoParams params) async {
    return await movierepository.getTrailerVideo(params.id!);
  }

  GetTrailervideoUsecase({required this.movierepository});
}
