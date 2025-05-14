import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/core/routes/app_routes.dart';
import 'package:movieapp/core/di/service_locator.dart';
import 'package:movieapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_event.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<MovieBloc>(create: (context) {
          final movieBloc = sl<MovieBloc>();
          movieBloc.add(GetAllMoviesEvent()); // Ajoutez cette ligne
          return movieBloc;
        }),
        BlocProvider<ChatBloc>(create: (context) {
          final chatBloc = sl<ChatBloc>();
          return chatBloc;
        }),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'movieapp',
          routerConfig: appRouter),
    );
  }
}
