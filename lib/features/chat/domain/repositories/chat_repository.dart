import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/features/chat/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatResponseEntity>>> getMovieRecommendation(String prompt);
}