import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> login(String mobile, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {
          'mobile_number': mobile,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final user = response.data['user'];

        // حفظ التوكن بعد تعديله ليتحول إلى نص بشكل صريح
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
        await prefs.setInt('user_id', user['id']);

        return {'success': true, 'user': user};
      }

      return {'success': false, 'message': 'Login failed'};

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return {'success': false, 'message': 'Wrong phone or password'};
      }
      return {'success': false, 'message': 'Connection error'};
    }
  }
}