import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/parent_home_model.dart';

class ParentHomeService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://observant-smile-production-931d.up.railway.app/api", // بدون /api
      headers: {"Accept": "application/json"},
    ),
  );

  Future<ParentHomeModel> getHomeData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('TOKEN: $token');

    try {
      final response = await _dio.get(
        "/user/home",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print('HOME DATA: ${response.data}');
      print('HOME DATA: ${response.data}');
      return ParentHomeModel.fromJson(response.data);
    } catch (e) {
      print('HOME ERROR: $e');
      rethrow;
    }
  }
}