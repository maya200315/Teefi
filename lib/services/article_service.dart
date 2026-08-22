import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://observant-smile-production-931d.up.railway.app/api",
      headers: {"Accept": "application/json"},
    ),
  );

  Future<Options> _authOptions() async {
    final prefs = await SharedPreferences.getInstance();
    //قراءة التوكن
    final token = prefs.getString('token');
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  // جلب كل المقالات للأدمن
  Future<List<dynamic>> getArticles() async {
    final response = await _dio.get(
      "/admin/articles",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  //  جلب مقالات الأهل
  Future<List<dynamic>> getUserArticles() async {
    final response = await _dio.get(
      "/user/articles",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // جلب تفاصيل مقال محدد
  Future<Map<String, dynamic>> getArticle(int id) async {
    final response = await _dio.get(
      "/admin/articles/$id",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // إضافة مقال
  Future<void> createArticle({
    required String title,
    required String content,
    required String datetime,
  }) async {
    await _dio.post(
      "/admin/articles",
      data: {"title": title, "content": content, "datetime": datetime},
      options: await _authOptions(),
    );
  }

  // تعديل مقال
  Future<void> updateArticle({
    required int id,
    required String title,
    required String content,
  }) async {
    final Map<String, dynamic> body = {};
    if (title.isNotEmpty) body["title"] = title;
    if (content.isNotEmpty) body["content"] = content;

    await _dio.put(
      "/admin/articles/$id",
      data: body,
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