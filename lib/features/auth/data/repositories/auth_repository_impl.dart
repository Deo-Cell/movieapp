import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/core/errors/exceptions.dart';
import 'package:movieapp/features/auth/data/models/user_model.dart';
import 'package:movieapp/features/auth/domain/repositories/auth_repositories.dart';
import 'package:movieapp/features/auth/data/datasources/auth_remote_datasource.dart';

@LazySingleton()
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  
  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserSessionModel>> createSession(
      String requestToken) async {
    try {
      return right(await authRemoteDatasource.createSessionId(requestToken));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getrequestToken() async {
    try {
      return right(await authRemoteDatasource.getRequestToken());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
