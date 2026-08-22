import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentPecsService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://observant-smile-production-931d.up.railway.app/api'));

  Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // GET /api/user/pecs-categories
  Future<List<dynamic>> getCategories() async {
    final token = await _token();
    final response = await _dio.get(
      '/user/pecs-categories',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data['data'] as List<dynamic>;
  }

  // GET /api/user/pecs-categories/{id}/cards
  Future<Map<String, dynamic>> getCategoryCards(int categoryId) async {
    final token = await _token();
    final response = await _dio.get(
      '/user/pecs-categories/$categoryId/cards',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as Map<String, dynamic>; // { status, category, data }
  }
}