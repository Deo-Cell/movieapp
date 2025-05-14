import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendPromptEvent extends ChatEvent {
  final String prompt;

  const SendPromptEvent(this.prompt);

  @override
  List<Object> get props => [prompt];
}