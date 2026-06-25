import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {
  Map<String, dynamic>? _data;
  bool _isLoading = false;
  String? _errorMessage;

  Map<String, dynamic>? get data => _data;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDashboard() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await DashboardService().getDashboardData();
      _data = result['data'];
    } catch (e) {
      _errorMessage = 'Failed to load dashboard';
    }

    _isLoading = false;
    notifyListeners();
  }
}