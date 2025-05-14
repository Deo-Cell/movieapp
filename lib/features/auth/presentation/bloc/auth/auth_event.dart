abstract class AuthEvent {}

class GetRequestTokenEvent extends AuthEvent {}

class CreateSessionEvent extends AuthEvent {
  final String requestToken;
  CreateSessionEvent({required this.requestToken});
}