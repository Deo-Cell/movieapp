import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/theme/app_sizes.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_event.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_state.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_event.dart';
import 'package:movieapp/features/chat/presentation/widgets/movie_card.dart';
import 'package:movieapp/features/movie/presentation/widgets/gradient_circle_widget.dart';

class ChatAIPage extends StatefulWidget {
  const ChatAIPage({super.key});

  @override
  State<ChatAIPage> createState() => _ChatAIPageState();
}

class _ChatAIPageState extends State<ChatAIPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isThinking = false;

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    context.read<ChatBloc>().add(SendPromptEvent(text));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBackground(),
          Column(
            children: [
              SizedBox(height: AppSpacing.sectionGap2),
              _buildHeader(),
              Expanded(
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatSuccess || state is ChatFailure) {
                      setState(() => _isThinking = false);
                      _scrollToBottom();
                    } else if (state is ChatLoading) {
                      setState(() => _isThinking = true);
                      _scrollToBottom();
                    }
                  },
                  builder: (context, state) {
                    // Obtenez les messages de n'importe quel état (tous les états ont une liste de messages maintenant)
                    final messages = state.messages;

                    return _buildChatMessages(messages);
                  },
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(children: [
      Positioned(
        top: -75,
        left: -190,
        child: buildGradientCircle(320, 380, AppColors.neonAqua),
      ),
      Positioned(
        bottom: 280,
        right: -270,
        child: buildGradientCircle(400, 480, AppColors.neonPink),
      ),
      Positioned(
        bottom: -50,
        left: -10,
        child: buildGradientCircle(200, 200, AppColors.neonBlue),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.black.withOpacity(0.1)),
      ),
    ]);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              context.read<MovieBloc>().add(GetAllMoviesEvent());
              context.go('/home');
            },
          ),
          const SizedBox(width: 8),
          const Text(
            'Chat IA',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
                color: Colors.greenAccent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          const Text('Online', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildChatMessages(List<Message> messages) {
    // Calcul du nombre d'éléments (messages + indicateur de chargement si nécessaire)
    final int itemCount = messages.length + (_isThinking ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Si c'est le dernier élément et que nous sommes en train de "penser", afficher l'indicateur
        if (_isThinking && index == messages.length) {
          return _buildThinkingIndicator();
        }
        // Sinon, afficher le message correspondant à l'index
        return _buildMessage(messages[index], index);
      },
    );
  }

  Widget _buildMessage(Message message, int index) {
    final bool isWelcomeMessage =
        index == 0 && !message.isUser && message.movies == null;

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: message.isUser || isWelcomeMessage
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser
              ? AppColors.neonBlue.withOpacity(0.7)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: message.isUser ? const Radius.circular(4) : null,
            bottomLeft: !message.isUser ? const Radius.circular(4) : null,
          ),
          border: Border.all(
            color: message.isUser
                ? AppColors.neonBlue
                : Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWelcomeMessage)
              AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    "Hello! I'm here to help you find the best movies for you.\nWhat are you looking for?",
                    speed: const Duration(milliseconds: 50),
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            if (message.text.isNotEmpty && !isWelcomeMessage)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  message.text,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            if (message.movies != null && message.movies!.isNotEmpty)
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: message.movies!.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final movie = message.movies![index];
                    return MovieRecommendationContainer(
                      imageUrl: movie.posterUrl,
                      movieId: movie.id!,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThinkingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: const Radius.circular(4),
          ),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(delay: 0),
            const SizedBox(width: 4),
            _buildDot(delay: 200),
            const SizedBox(width: 4),
            _buildDot(delay: 400),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required int delay}) => ThinkingDot(delayMillis: delay);

  Widget _buildInputArea() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.mic, color: AppColors.neonAqua),
              onPressed: () {}),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Write your message...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
              icon: Icon(Icons.attach_file, color: AppColors.neonPink),
              onPressed: () {}),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.neonBlue, AppColors.neonPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ThinkingDot extends StatefulWidget {
  final int delayMillis;
  const ThinkingDot({super.key, required this.delayMillis});

  @override
  State<ThinkingDot> createState() => _ThinkingDotState();
}

class _ThinkingDotState extends State<ThinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    Future.delayed(Duration(milliseconds: widget.delayMillis), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
