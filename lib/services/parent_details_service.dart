import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentDetailsService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  Future<Map<String, dynamic>> getParentById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get(
      "/admin/users/parents/$id",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data['data'];
  }
}