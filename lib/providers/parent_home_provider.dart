import 'package:flutter/material.dart';
import '../services/parent_home_service.dart';
import '../models/parent_home_model.dart';

class ParentHomeProvider extends ChangeNotifier {
  final ParentHomeService _service = ParentHomeService();

  ParentHomeModel? _homeData;
  bool _isLoading = false;
  String? _errorMessage;

  ParentHomeModel? get homeData => _homeData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _homeData = await _service.getHomeData();
    } catch (e) {
      _errorMessage = 'Failed to load home data';
    }

    _isLoading = false;
    notifyListeners();
  }
}