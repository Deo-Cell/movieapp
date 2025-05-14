import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/params/chat_params.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_event.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_state.dart';
import 'package:movieapp/features/chat/domain/use_cases/sendchat_usecase.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendChatUsecase getRecommendationUseCase;
  final List<Message> _chatHistory = [
    Message(
      text: "Hello! I'm your AI assistant. Which movie do you want to watch?",
      isUser: false,
    ),
  ];

  ChatBloc(this.getRecommendationUseCase) : super(ChatSuccess([
    Message(
      text: "Hello! I'm your AI assistant. Which movie do you want to watch?",
      isUser: false,
    )
  ])) {
    on<SendPromptEvent>(_onSendPrompt);
  }

  Future<void> _onSendPrompt(SendPromptEvent event, Emitter<ChatState> emit) async {
    // Ajouter le message de l'utilisateur à l'historique
    _chatHistory.add(Message(text: event.prompt, isUser: true));
    
    // Émettre l'état avec l'historique mis à jour incluant le message de l'utilisateur
    emit(ChatSuccess(List.from(_chatHistory)));
    
    // Émettre l'état de chargement tout en conservant l'historique existant
    emit(ChatLoading(messages: List.from(_chatHistory)));
    
    final result = await getRecommendationUseCase(ChatParams(prompt: event.prompt));

    result.fold(
      (failure) => emit(ChatFailure(failure.message, messages: List.from(_chatHistory))),
      (chatResponse) {
        // Ajouter le nouveau message de réponse à l'historique
        _chatHistory.add(Message(
          text: "A special screening just for you. Here's my selection:", // Message de réponse générique
          isUser: false,
          movies: chatResponse,
        ));
        
        // Émettre le nouvel état avec l'historique complet mis à jour
        emit(ChatSuccess(List.from(_chatHistory)));
      },
    );
  }
}