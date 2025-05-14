import 'package:equatable/equatable.dart';
import 'package:movieapp/features/chat/domain/entities/chat_entity.dart';

abstract class ChatState extends Equatable {
  final List<Message> messages;
  
  const ChatState({this.messages = const []});
  
  @override
  List<Object?> get props => [messages];
}
class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  @override
  final List<Message> messages;

  const ChatLoading({required this.messages});
}

class ChatSuccess extends ChatState {
  @override
  final List<Message> messages;

  const ChatSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatFailure extends ChatState {
  final String error;
  @override
  final List<Message> messages;

  const ChatFailure(this.error, {required this.messages});

  @override
  List<Object> get props => [error, messages];
}

class Message {
  final String text;
  final bool isUser;
  final List<ChatResponseEntity>? movies;

  Message({required this.text, required this.isUser, this.movies});
}