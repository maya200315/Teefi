// lib/services/superadmin_pecs_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/superadmin_pecs_card_model.dart';

class SuperAdminPecsService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<SuperAdminPecsCardModel>> getAllPecsCards() async {
    final response = await _dio.get(
      '/superadmin/pecs-cards',
      options: await _authOptions(),
    );
    // ⚠️ لا يوجد 'status' هون، بس current_page + data مباشرة
    final list = response.data['data'] as List;
    return list.map((c) => SuperAdminPecsCardModel.fromJson(c)).toList();
  }
}