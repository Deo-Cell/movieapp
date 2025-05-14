import 'dart:convert';
import 'package:movieapp/features/auth/domain/entities/user_entity.dart';


class UserSessionModel extends UserEntity {
  
  UserSessionModel({required super.sessionId, super.isGuest});

  factory UserSessionModel.fromJson(Map<String, dynamic> json) {
    return UserSessionModel(
      sessionId: json['session_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
    };
  }

   String toJsonString() => jsonEncode(toJson());

  factory UserSessionModel.fromJsonString(String jsonString) {
    return UserSessionModel.fromJson(jsonDecode(jsonString));
  }
}
