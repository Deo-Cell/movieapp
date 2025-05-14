import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/params/chat_params.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/features/chat/domain/entities/chat_entity.dart';
import 'package:movieapp/features/chat/data/repositories/chat_repository_impl.dart';



@injectable
class SendChatUsecase implements Usecase<List<ChatResponseEntity>, ChatParams> {
  final ChatRepositoryImpl chatRepository;
  SendChatUsecase(this.chatRepository);
  @override
  Future<Either<Failure, List<ChatResponseEntity>>> call(ChatParams params) {
    return chatRepository.getMovieRecommendation(params.prompt);
  }
}
  