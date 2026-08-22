import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://observant-smile-production-931d.up.railway.app/api';

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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
        await prefs.setInt('user_id', user['id']);
        await prefs.setInt('role_id', (user['Roleid'] as int?) ?? 0); // ✅ بحرف كبير R

        return {'success': true, 'user': user};
      }

      return {'success': false, 'message': 'Login failed'};

    } on DioException catch (e) {
      print('=== LOGIN ERROR DEBUG ===');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      print('Request data sent: ${e.requestOptions.data}');
      print('=========================');

      if (e.response?.statusCode == 401) {
        return {'success': false, 'message': 'Wrong phone or password'};
      }
      return {'success': false, 'message': 'Connection error'};
    }
  }

  //  لوغ أوت
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      await _dio.post(
        '$_baseUrl/logout',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      // حتى لو فشل الـ API نمسح التوكن
    }

    await prefs.clear();
  }
}