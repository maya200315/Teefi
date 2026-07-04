import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PecsService {
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

  //  Categories

  // جلب كل الكاتيجوريز
  Future<List<dynamic>> getCategories() async {
    final response = await _dio.get(
      "/admin/pecs-card-categories",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // جلب كاتيجوري واحدة مع كارداتها
  Future<Map<String, dynamic>> getCategory(int id) async {
    final response = await _dio.get(
      "/admin/pecs-card-categories/$id",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // إضافة كاتيجوري
  Future<void> createCategory({required String name}) async {
    await _dio.post(
      "/admin/pecs-card-categories",
      data: {"name": name},
      options: await _authOptions(),
    );
  }

  // تعديل كاتيجوري
  Future<void> updateCategory({required int id, required String name}) async {
    await _dio.put(
      "/admin/pecs-card-categories/$id",
      data: {"name": name},
      options: await _authOptions(),
    );
  }

  // حذف كاتيجوري
  Future<void> deleteCategory(int id) async {
    await _dio.delete(
      "/admin/pecs-card-categories/$id",
      options: await _authOptions(),
    );
  }

  // ─── Cards

  // جلب كارد واحد
  Future<Map<String, dynamic>> getCard(int id) async {
    final response = await _dio.get(
      "/admin/pecs-cards/$id",
      options: await _authOptions(),
    );
    return response.data['data'];
  }

  // إضافة كارد مع صورة (form-data)
  Future<void> createCard({
    required String title,
    required int categoryId,
    required String imagePath, // المسار المحلي للصورة
  }) async {
    final formData = FormData.fromMap({
      "title": title,
      "PECS_card_categoryid": categoryId,
      "image": await MultipartFile.fromFile(imagePath),
    });

    await _dio.post(
      "/admin/pecs-cards",
      data: formData,
      options: await _authOptions(),
    );
  }

  // تعديل كارد
  Future<void> updateCard({
    required int id,
    required String title,
    required int categoryId,
    String? imagePath,
  }) async {
    final map = <String, dynamic>{
      "title": title,
      "PECS_card_categoryid": categoryId, //
      "_method": "PUT",                     //
    };

    if (imagePath != null) {
      map["image"] = await MultipartFile.fromFile(imagePath);
    }

    await _dio.post(
      "/admin/pecs-cards/$id",
      data: FormData.fromMap(map),
      options: await _authOptions(),
    );
  }

  // حذف كارد
  Future<void> deleteCard(int id) async {
    await _dio.delete(
      "/admin/pecs-cards/$id",
      options: await _authOptions(),
    );
  }
}