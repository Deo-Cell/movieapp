import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/constants/api_constant.dart';
import 'package:movieapp/core/common/shared_preferences.dart';
import 'package:movieapp/features/auth/data/models/user_model.dart';



abstract interface class AuthRemoteDatasource {
  Future<String> getRequestToken();
  Future<UserSessionModel> createSessionId(String requestToken);
}

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio = Dio();
  final SharedPreferencesStorage localStorage = SharedPreferencesStorage();
  @override
  Future<String> getRequestToken() async {
    print("Enter in the function request token");
    final response = await dio.get(
      ApiConstant.getrequestToken,
      queryParameters: {"api_key": ApiConstant.apiKey},
    );
    print("response: ${response.data}");
    return response.data['request_token'];
  }

  @override
  Future<UserSessionModel> createSessionId(String requestToken) async {
    final response = await dio.post(
      ApiConstant.createSessionId,
      queryParameters: {"api_key": ApiConstant.apiKey},
      data: {"request_token": requestToken},
    );
    var session = UserSessionModel.fromJson(response.data);
    localStorage.saveSession(session);
    return session;
  }
}