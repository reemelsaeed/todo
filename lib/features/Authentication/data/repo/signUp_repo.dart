import 'package:todo_app/core/api/api_endpoints.dart';
import 'package:todo_app/core/api/api_services.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';

class SignupRepo {
  final ApiServices apiService;

  SignupRepo(this.apiService);

  Future<Usermodel> signUp({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
  }) async {
    final response = await apiService.dio.post(
      ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );

    final token = response.data['data']['token'];
    final user = Usermodel.fromJson(response.data['data']['user']);

    await apiService.setToken(token);
    return user;
  }
}
