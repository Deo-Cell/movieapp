import 'package:go_router/go_router.dart';
import 'package:movieapp/core/routes/auth_guards.dart';
import 'package:movieapp/core/routes/router_utils.dart';
import 'package:movieapp/features/home/presentation/pages/home_page.dart';
import 'package:movieapp/features/chat/presentation/pages/chatai_page.dart';
import 'package:movieapp/features/auth/presentation/pages/login/login_page.dart';
import 'package:movieapp/features/movie/presentation/pages/moviedetails_page.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.home, // Page de démarrage
  routes: [
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home,
      
      builder: (context, state) => const HomePage(),
      redirect: (context, state) => AuthGuard().checkAuth(context),
    ),
    GoRoute(
      path: RoutePaths.chatai,
      name: RouteNames.chatai,
      builder: (context, state) => const ChatAIPage(),
    ),
    GoRoute(
      path: RoutePaths.moviedetails,
      name: RouteNames.moviedetails,
      builder: (context, state) {
        final movieId = int.tryParse(state.pathParameters['movieId'] ?? '') ?? 0;
        return MoviedetailsPage(movieId: movieId);
      },
      )
  ],
);