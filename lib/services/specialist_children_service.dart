// lib/services/specialist_children_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/specialist_children_model.dart';

class SpecialistChildrenService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<SpecialistChildrenModel> getMyChildren() async {
    final response = await _dio.get(
      '/specialist/MyChildren',
      options: await _authOptions(),
    );
    return SpecialistChildrenModel.fromJson(response.data);
  }
}