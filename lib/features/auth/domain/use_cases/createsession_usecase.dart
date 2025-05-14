import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/features/auth/data/models/user_model.dart';
import 'package:movieapp/features/auth/data/repositories/auth_repository_impl.dart';


@injectable
class CreatesessionUsecase implements Usecase<UserSessionModel, String> {
  final AuthRepositoryImpl authRepository;
  CreatesessionUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserSessionModel>> call(String params) async {
    return await authRepository.createSession(params);
  }
}

