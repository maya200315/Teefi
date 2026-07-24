

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

  Future<void> loadReports(int childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.getWeeklyReport(childId),
        _service.getMonthlyReport(childId),
        _service.getChartData(childId, selectedPeriod),
      ]);

      weeklyReport = results[0] as ReportModel;
      monthlyReport = results[1] as ReportModel;
      chartData = results[2] as ChartDataModel;
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