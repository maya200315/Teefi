import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      headers: {"Accept": "application/json"},
    ),
  );

  Future<Options> _authOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  // جلب كل المقالات
  Future<List<dynamic>> getArticles() async {
    final response = await _dio.get(
      "/admin/articles",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // إضافة مقال
  Future<void> createArticle({
    required String title,
    required String content,
  }) async {
    await _dio.post(
      "/admin/articles",
      data: {"title": title, "content": content},
      options: await _authOptions(),
    );
  }

  // تعديل مقال
  Future<void> updateArticle({
    required int id,
    required String title,
    required String content,
  }) async {
    await _dio.put(
      "/admin/articles/$id",
      data: {"title": title, "content": content},
      options: await _authOptions(),
    );
  }

  // حذف مقال
  Future<void> deleteArticle(int id) async {
    await _dio.delete(
      "/admin/articles/$id",
      options: await _authOptions(),
    );
  }
}