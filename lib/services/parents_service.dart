import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentsService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  // دالة جلب قائمة أولياء الأمور
  Future<List<dynamic>> getParents() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get(
      "/admin/users/parents",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data['data'];
  }

  // ✅ دالة إنشاء حساب ولي أمر جديد
  Future<void> createParent({
    required String name,
    required String mobileNumber,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await _dio.post(
      "/admin/users/parents",
      data: {
        "name": name,
        "mobile_number": mobileNumber,
        "password": password,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}