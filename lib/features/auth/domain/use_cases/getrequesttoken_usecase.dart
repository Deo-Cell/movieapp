import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/params/noparams.dart';
import 'package:movieapp/core/usescases/usecases.dart';
import 'package:movieapp/features/auth/data/repositories/auth_repository_impl.dart';


@injectable
class GetrequesttokenUsecase implements Usecase<String, NoParams> {
  final AuthRepositoryImpl authRepository;
  GetrequesttokenUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getrequestToken();
  }
}
