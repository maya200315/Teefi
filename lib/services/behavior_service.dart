import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BehaviorService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://observant-smile-production-931d.up.railway.app/api'));

  Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // GET /api/user/children
  Future<List<dynamic>> getChildren() async {
    final token = await _token();
    final response = await _dio.get(
      '/user/children',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print('BEHAVIOR SERVICE: children status => ${response.statusCode}');
    print('BEHAVIOR SERVICE: children raw => ${response.data}');
    return response.data as List<dynamic>;
  }

  // GET /api/user/children/{id}/profile
  Future<Map<String, dynamic>> getChildProfile(int childId) async {
    final token = await _token();
    final response = await _dio.get(
      '/user/children/$childId/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as Map<String, dynamic>;
  }

  // GET /api/user/behavior-types
  Future<List<dynamic>> getBehaviorTypes() async {
    final token = await _token();
    final response = await _dio.get(
      '/user/behavior-types',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print('BEHAVIOR SERVICE: types status => ${response.statusCode}');
    print('BEHAVIOR SERVICE: types raw => ${response.data}');
    return response.data as List<dynamic>;
  }

  // POST /api/user/behaviors
  Future<void> createBehavior({
    required int childId,
    required int behaviorTypeId,
    String? notes,
  }) async {
    print("POST API CALLED");
    print("ChildId = $childId");
    print("BehaviorTypeId = $behaviorTypeId");
    print("Notes = $notes");
    final token = await _token();
    await _dio.post(
      '/user/behaviors',
      data: {
        'Childid': childId,
        'Behavior_typeid': behaviorTypeId,
        'notes': notes ?? '',
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}