// lib/services/superadmin_specialists_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/superadmin_specialist_model.dart';
import '../models/specialist_children_model.dart'; // لإعادة استخدام SpecialistChildModel

class SuperAdminSpecialistsService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://observant-smile-production-931d.up.railway.app/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<SuperAdminSpecialistModel>> getAllSpecialists() async {
    final response = await _dio.get(
      '/superadmin/specialist',
      options: await _authOptions(),
    );
    final list = response.data['data'] as List;
    return list.map((s) => SuperAdminSpecialistModel.fromJson(s)).toList();
  }

  Future<List<SpecialistChildModel>> getChildrenForSpecialist(int specialistId) async {
    final response = await _dio.get(
      '/superadmin/specialists/$specialistId/children',
      options: await _authOptions(),
    );
    final children = response.data['children'] as List;
    return children.map((c) => SpecialistChildModel.fromJson(c)).toList();
  }
}