import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dio.get(
        'http://10.0.2.2:8000/api/admin/dashboard',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data;
    } catch (e) {
      throw Exception('Failed to load dashboard data');
    }
  }
}