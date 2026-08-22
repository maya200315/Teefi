import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://observant-smile-production-931d.up.railway.app/api",
    ),
  );

  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dio.get(
        '/admin/dashboard',
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