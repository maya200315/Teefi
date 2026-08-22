import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentsService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://observant-smile-production-931d.up.railway.app/api",
      headers: {"Accept": "application/json"},
    ),
  );

  Future<Options> _authOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<List<dynamic>> getParents() async {
    final response = await _dio.get(
      "/admin/users/parents",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  Future<void> createParent({
    required String name,
    required String mobileNumber,
    required String password,
    required String autismLevel,
    required int specialistId,
    int? age,
  }) async {
    final Map<String, dynamic> body = {
      "name": name,
      "mobile_number": mobileNumber,
      "password": password,
      "autism_level": autismLevel,
      "specialist_id": specialistId,
    };
    if (age != null) body["age"] = age.toString();

    await _dio.post(
      "/admin/users/parents",
      data: body,
      options: await _authOptions(),
    );
  }

  Future<void> updateParent({
    required int id,
    required String name,
    required String mobileNumber,
    String? password,
  }) async {
    final Map<String, dynamic> body = {
      "name": name,
      "mobile_number": mobileNumber,
    };
    if (password != null && password.isNotEmpty) {
      body["password"] = password;
    }

    await _dio.put(
      "/admin/users/parents/$id",
      data: body,
      options: await _authOptions(),
    );
  }

  Future<void> deleteParent(int id) async {
    await _dio.delete(
      "/admin/users/parents/$id",
      options: await _authOptions(),
    );
  }
}