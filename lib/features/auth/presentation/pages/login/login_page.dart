import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movieapp/core/common/toast.dart';
import 'package:movieapp/core/theme/app_sizes.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:movieapp/core/common/text_component.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:movieapp/features/auth/presentation/bloc/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  String? requestToken;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // L'utilisateur est revenu dans l'application
      context
          .read<AuthBloc>()
          .add(CreateSessionEvent(requestToken: requestToken!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            CustomToast.showError(context, message: state.errorMessage);
          }
          if (state is AuthTokenReceived) {
            print("cc");
            launchTMDbAuth(context, state.requestToken);
            requestToken = state.requestToken;
           // print("requestToken: $requestToken");
          }

          if (state is AuthSuccess) {
            context.go('/home');
            CustomToast.showSuccess(context, message: "Login successful");
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Stack(
              children: [
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: AppColors.neonAqua,
                      size: 100,
                    ),
                  ),
                ),
              ],
            );
          }
          return Stack(
            children: [
              // Fond noir
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.darkBackground,
                ),
              ),

              // Dégradé violet (en haut à gauche)
              Positioned(
                top: -10,
                left: -150,
                child: Container(
                  width: 420,
                  height: 480,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.neonPink, Colors.transparent],
                      radius: 0.8,
                    ),
                  ),
                ),
              ),

              // Dégradé vert (en bas à droite)
              Positioned(
                bottom: 280,
                right: -150,
                child: Container(
                  width: 400,
                  height: 480,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.neonAqua, Colors.transparent],
                      radius: 0.8,
                    ),
                  ),
                ),
              ),

              // Effet blur pour un rendu plus doux
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),

              Positioned(
                top: AppScreenSize.screenheight(context) * 0.15,
                left: 30,
                child: Container(
                  height: 350,
                  width: Responsive.responsiveSize(350, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: GradientBoxBorder(
                      gradient: AppColors.neonGradientAvatar,
                      width: 5,
                    ),
                  ),
                  child: ClipOval(
                    // Ajouter ClipOval pour s'assurer que l'image est découpée en cercle
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 10, right: 10),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: AppScreenSize.screenheight(context) * 0.58,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centre horizontalement
                  children: [
                    TextComponent(
                      "Watch movies in",
                      textcolor: Colors.white.withAlpha((0.85 * 255).toInt()),
                      fontweight: FontWeight.bold,
                      fontsize: AppFontSize.headline,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5), // Espacement entre les textes
                    TextComponent(
                      "Virtual Reality",
                      textcolor: Colors.white.withAlpha((0.85 * 255).toInt()),
                      fontweight: FontWeight.bold,
                      fontsize: AppFontSize.headline,
                      textAlign: TextAlign.center,
                      fontfamily: 'Open Sans',
                    ),
                  ],
                ),
              ),
              Positioned(
                top: AppScreenSize.screenheight(context) * 0.73,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centre horizontalement
                  children: [
                    TextComponent(
                      "Download and watch offline",
                      textcolor: Colors.white.withAlpha((0.75 * 255).toInt()),
                      //fontweight: FontWeight.bold,
                      fontsize: AppFontSize.body,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5), // Espacement entre les textes
                    TextComponent(
                      "wherever you are",
                      textcolor: Colors.white.withAlpha((0.75 * 255).toInt()),
                      fontsize: AppFontSize.body,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Positioned(
                top: AppScreenSize.screenheight(context) * 0.81,
                left: 135,
                child: SizedBox(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [AppColors.neonPink, Colors.transparent],
                              radius: 0.8,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [AppColors.neonAqua, Colors.transparent],
                              radius: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                  top: AppScreenSize.screenheight(context) * 0.83,
                  left: 135,
                  right: 130,
                  child: GestureDetector(
                    onTap: () {
                      print("Sign in");
                      context.read<AuthBloc>().add(GetRequestTokenEvent());
                    },
                    child: Container(
                      height: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: GradientBoxBorder(
                          gradient: AppColors.neonGradientBorder,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: TextComponent(
                          "Sign In",
                          textcolor:
                              Colors.white.withAlpha((0.85 * 255).toInt()),
                          fontsize: AppFontSize.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

void launchTMDbAuth(BuildContext context, String requestToken) async {
  final Uri url =
      Uri.parse("https://www.themoviedb.org/authenticate/$requestToken");

  if (await canLaunchUrl(url)) {
    print("ccggugu");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
