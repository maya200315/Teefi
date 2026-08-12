import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/report_model.dart';

class ReportService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _authOptions() async {
    final token = await _getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<ReportModel> getWeeklyReport(int childId) async {
    final response = await _dio.get(
      '/user/children/$childId/reports/weekly',
      options: await _authOptions(),
    );
    return ReportModel.fromJson(response.data['data']);
  }

  Future<ReportModel> getMonthlyReport(int childId) async {
    final response = await _dio.get(
      '/user/children/$childId/reports/monthly',
      options: await _authOptions(),
    );
    return ReportModel.fromJson(response.data['data']);
  }

  Future<ChartDataModel> getChartData(int childId, String period) async {
    final response = await _dio.get(
      '/user/children/$childId/reports/chart',
      queryParameters: {'period': period},
      options: await _authOptions(),
    );
    return ChartDataModel.fromJson(response.data['data']);
  }

  Future<List<RecommendationModel>> getRecommendations(int childId) async {
    final response = await _dio.get(
      '/user/children/$childId/recommendations',
      options: await _authOptions(),
    );
    final list = response.data['data'] as List;
    return list.map((r) => RecommendationModel.fromJson(r)).toList();
  }
}