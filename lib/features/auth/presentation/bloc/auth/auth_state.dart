abstract class AuthState {}


class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String sessionId;
  final bool? isGuest;
  AuthSuccess({required this.sessionId, this.isGuest});
}

class AuthTokenReceived extends AuthState {
  final String requestToken;
  AuthTokenReceived(this.requestToken);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(String string, {required this.errorMessage});
}

