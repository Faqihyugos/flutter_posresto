import 'package:dartz/dartz.dart';
import 'package:flutter_posresto/core/constants/variable.dart';
import 'package:flutter_posresto/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variable.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to login');
    }
  }

  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final url = Uri.parse('${Variable.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to logout');
    }
  }
}
