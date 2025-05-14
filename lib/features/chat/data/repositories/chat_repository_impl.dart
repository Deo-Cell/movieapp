import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/features/chat/domain/entities/chat_entity.dart';
import 'package:movieapp/features/chat/domain/repositories/chat_repository.dart';
import 'package:movieapp/features/chat/data/datasources/chat_remote_datasource.dart';


@LazySingleton()
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ChatResponseEntity>>> getMovieRecommendation(String prompt) async {
    try {
      final response = await remoteDataSource.getRecommendation(prompt);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}