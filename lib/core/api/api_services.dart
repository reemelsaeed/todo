import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  late final Dio dio;
  String? token;

  ApiServices() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.gosorsolutions.com/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    // ____________________________________________ //
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('=== TOKEN: $token ===');
          print('=== URL: ${options.baseUrl}${options.path} ===');
          return handler.next(options);
        },
      ),
    );
    // ____________________________________________ //
  }
  //set token
  Future<void> setToken(String newtoken) async {
    token = newtoken;
    final prfs = await SharedPreferences.getInstance();
    await prfs.setString('access_token', newtoken);
  }

  //load token
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
  }
  //clear token

  Future<void> clearToken() async {
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
