// lib/services/complaint_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/complaint_model.dart';

class ComplaintService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://observant-smile-production-931d.up.railway.app/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<ComplaintModel> submitComplaint(String title, String message) async {
    final response = await _dio.post(
      '/user/complaints',
      data: {'title': title, 'message': message},
      options: await _authOptions(),
    );
    return ComplaintModel.fromJson(response.data['complaint']);
  }
}