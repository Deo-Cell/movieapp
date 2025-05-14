import 'package:shared_preferences/shared_preferences.dart';
import 'package:movieapp/features/auth/data/models/user_model.dart';


class SharedPreferencesStorage {
  static const String _sessionKey = 'userSession';

  Future<void> saveSession(UserSessionModel session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, session.toJsonString());
  }

  Future<UserSessionModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_sessionKey);
    if (jsonString == null) return null;
    return UserSessionModel.fromJsonString(jsonString);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
