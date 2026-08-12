import 'package:flutter/material.dart';
import '../models/report_model.dart';
import '../services/report_service.dart';

class ReportProvider extends ChangeNotifier {
  final ReportService _service = ReportService();

  bool isLoading = false;
  String? errorMessage;

  String selectedPeriod = 'weekly'; // 'weekly' or 'monthly'

  ReportModel? weeklyReport;
  ReportModel? monthlyReport;
  ChartDataModel? chartData;
  List<RecommendationModel> recommendations = [];

  Future<void> loadReports(int childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.getWeeklyReport(childId),
        _service.getMonthlyReport(childId),
        _service.getChartData(childId, selectedPeriod),
        _service.getRecommendations(childId),
      ]);

      weeklyReport = results[0] as ReportModel;
      monthlyReport = results[1] as ReportModel;
      chartData = results[2] as ChartDataModel;
      recommendations = results[3] as List<RecommendationModel>;
    } catch (e) {
      errorMessage = 'تعذر تحميل التقرير';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> switchPeriod(int childId, String period) async {
    if (selectedPeriod == period) return;
    selectedPeriod = period;
    notifyListeners();

    try {
      chartData = await _service.getChartData(childId, period);
    } catch (e) {
      errorMessage = 'تعذر تحميل المخطط';
    }
    notifyListeners();
  }
}