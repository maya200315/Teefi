// lib/providers/specialist_report_provider.dart

import 'package:flutter/material.dart';
import '../models/specialist_report_model.dart';
import '../models/report_model.dart';
import '../services/specialist_report_service.dart';

class SpecialistReportProvider extends ChangeNotifier {
  final SpecialistReportService _service = SpecialistReportService();

  bool isLoading = false;
  String? errorMessage;

  bool isSavingRecommendation = false;
  String? recommendationError;

  String selectedPeriod = 'weekly';

  SpecialistReportModel? weeklyReport;
  SpecialistReportModel? monthlyReport;
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

      weeklyReport = results[0] as SpecialistReportModel;
      monthlyReport = results[1] as SpecialistReportModel;
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

  Future<bool> saveRecommendation(int childId, String text) async {
    isSavingRecommendation = true;
    recommendationError = null;
    notifyListeners();

    bool success = false;
    try {
      await _service.addRecommendation(childId, text);
      success = true;
    } catch (e) {
      recommendationError = 'تعذر حفظ التوصية';
    }

    isSavingRecommendation = false;
    notifyListeners();
    return success;
  }
}