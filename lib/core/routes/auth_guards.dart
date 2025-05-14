import 'package:flutter/material.dart';
import 'package:movieapp/core/routes/router_utils.dart';
import 'package:movieapp/core/common/shared_preferences.dart';

class AuthGuard {
  Future<String?> checkAuth(BuildContext context) async {
    final session = await SharedPreferencesStorage().getSession();
    final isLoggedIn = session?.sessionId != null;
    return isLoggedIn ? RoutePaths.home : RoutePaths.login; // Redirection si non connecté
  }
}
