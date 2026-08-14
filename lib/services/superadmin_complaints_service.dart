// lib/services/superadmin_complaints_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/superadmin_complaint_model.dart';

class SuperAdminComplaintsService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<SuperAdminComplaintModel>> getAllComplaints() async {
    final response = await _dio.get(
      '/superadmin/complaints',
      options: await _authOptions(),
    );
    final list = response.data['data'] as List;
    return list.map((c) => SuperAdminComplaintModel.fromJson(c)).toList();
  }
}