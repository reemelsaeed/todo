import 'package:todo_app/core/api/api_endpoints.dart';
import 'package:todo_app/core/api/api_services.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';

class LoginRepo {
  final ApiServices apiService;

  LoginRepo(this.apiService);

  Future<Usermodel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    final token = response.data['data']['token'];
    final user = Usermodel.fromJson(response.data['data']['user']);

    await apiService.setToken(token);
    return user;
  }
}
