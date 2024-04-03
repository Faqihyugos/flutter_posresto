import 'package:flutter_posresto/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final refs = await SharedPreferences.getInstance();
    await refs.setString('auth_data', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    final refs = await SharedPreferences.getInstance();
    await refs.remove('auth_data');
  }

  Future<AuthResponseModel> getAuthData() async {
    final refs = await SharedPreferences.getInstance();
    final authData = refs.getString('auth_data');
    return AuthResponseModel.fromJson(authData!);
  }

  Future<bool> isAuthDataExist() async {
    final refs = await SharedPreferences.getInstance();
    return refs.containsKey('auth_data');
  }
}
