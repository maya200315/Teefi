import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialistService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      headers: {"Accept": "application/json"},
    ),
  );

  Future<Options> _authOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  // جلب كل الأخصائيين
  Future<List<dynamic>> getSpecialists() async {
    final response = await _dio.get(
      "/admin/users/specialists",
      options: await _authOptions(),
    );
    print('SPECIALISTS: ${response.data}'); //
    return response.data['data'];
  }

  // جلب أخصائي واحد
  Future<Map<String, dynamic>> getSpecialist(int id) async {
    final response = await _dio.get(
      "/admin/users/specialists/$id",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // إضافة أخصائي
  Future<void> createSpecialist({
    required String name,
    required String mobileNumber,
    required String password,
    required String specialty,
  }) async {
    await _dio.post(
      "/admin/users/specialists",
      data: {
        "name": name,
        "mobile_number": mobileNumber,
        "password": password,
        "specialty": specialty,
      },
      options: await _authOptions(),
    );
  }

  // تعديل أخصائي
  Future<void> updateSpecialist({
    required int id,
    required String name,
    required String mobileNumber,
    required String specialty,
    String? password,
  }) async {
    final Map<String, dynamic> body = {
      "name": name,
      "mobile_number": mobileNumber,
      "specialty": specialty,
    };
    if (password != null && password.isNotEmpty) {
      body["password"] = password;
    }
    await _dio.put(
      "/admin/users/specialists/$id", //
      data: body,
      options: await _authOptions(),
    );
  }

  // حذف أخصائي
  Future<void> deleteSpecialist(int id) async {
    await _dio.delete(
      "/admin/users/specialists/$id",
      options: await _authOptions(),
    );
  }
}