import 'package:fpdart/fpdart.dart';
import 'package:movieapp/core/errors/failure.dart';
import 'package:movieapp/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
 Future<Either<Failure, String>> getrequestToken();
  Future<Either<Failure, UserSessionModel>> createSession(String requestToken);
  
}