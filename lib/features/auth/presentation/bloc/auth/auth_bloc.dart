import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/params/noparams.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:movieapp/features/auth/domain/use_cases/createsession_usecase.dart';
import 'package:movieapp/features/auth/domain/use_cases/getrequesttoken_usecase.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetrequesttokenUsecase getRequestTokenUsecase;
  final CreatesessionUsecase createSessionUsecase;

  AuthBloc({
    required this.getRequestTokenUsecase,
    required this.createSessionUsecase,
  }) : super(AuthInitial()) {
    on<GetRequestTokenEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await getRequestTokenUsecase.call(NoParams());
      print(result);
      result.fold(
          (failure) =>
              emit(AuthFailure("Error", errorMessage: failure.message)),
          (requestToken) {
        print(requestToken);
        emit(AuthTokenReceived(requestToken));
      });
    });

    on<CreateSessionEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await createSessionUsecase.call(event.requestToken);

      result.fold(
        (failure) => emit(AuthFailure("Error",
            errorMessage:
                failure.message)), // 🔥 Utilisation de failure.message
        (userSession) => emit(AuthSuccess(sessionId: userSession.sessionId)),
      );
    });
  }
}
