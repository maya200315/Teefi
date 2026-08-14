// lib/services/superadmin_articles_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/superadmin_article_model.dart';

class SuperAdminArticlesService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<SuperAdminArticleModel>> getAllArticles() async {
    final response = await _dio.get(
      '/superadmin/articles',
      options: await _authOptions(),
    );
    final list = response.data['data'] as List;
    return list.map((a) => SuperAdminArticleModel.fromJson(a)).toList();
  }
}