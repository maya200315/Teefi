// lib/services/specialist_report_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/specialist_report_model.dart';
import '../models/report_model.dart'; // ChartDataModel

class SpecialistReportService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<SpecialistReportModel> getWeeklyReport(int childId) async {
    final response = await _dio.get(
      '/specialist/children/$childId/reports/weekly',
      options: await _authOptions(),
    );
    // ⚠️ بنمرر response.data كامل (فيه status+data+parent_notes)
    // مش response.data['data'] زي قبل
    return SpecialistReportModel.fromJson(response.data);
  }

  Future<SpecialistReportModel> getMonthlyReport(int childId) async {
    final response = await _dio.get(
      '/specialist/children/$childId/reports/monthly',
      options: await _authOptions(),
    );
    return SpecialistReportModel.fromJson(response.data);
  }

  Future<ChartDataModel> getChartData(int childId, String period) async {
    final response = await _dio.get(
      '/specialist/children/$childId/reports/chart',
      queryParameters: {'period': period},
      options: await _authOptions(),
    );
    return ChartDataModel.fromJson(response.data['data']);
  }

  Future<void> addRecommendation(int childId, String text) async {
    await _dio.post(
      '/specialist/children/$childId/recommendations',
      data: {'text': text},
      options: await _authOptions(),
    );
  }
}