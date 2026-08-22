// lib/services/superadmin_children_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/superadmin_child_model.dart';

class SuperAdminChildrenService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://observant-smile-production-931d.up.railway.app/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<SuperAdminChildModel>> getAllChildren() async {
    final response = await _dio.get(
      '/superadmin/children',
      options: await _authOptions(),
    );
    // ⚠️ لا يوجد 'status' هون، بس current_page + data مباشرة (نفس نمط pecs-cards)
    final list = response.data['data'] as List;
    return list.map((c) => SuperAdminChildModel.fromJson(c)).toList();
  }
}