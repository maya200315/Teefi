import 'package:flutter/material.dart';
import '../services/parent_details_service.dart';

class ParentDetailsProvider extends ChangeNotifier {
  Map<String, dynamic>? _parentData;
  bool _isLoading = false;
  String? _errorMessage;

  Map<String, dynamic>? get parentData => _parentData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchParentById(int id) async {
    _parentData = null;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _parentData = await ParentDetailsService().getParentById(id);
    } catch (e) {
      _errorMessage = 'Failed to load parent details';
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ مهم — نظفي البيانات لما تفتحي شاشة إضافة جديدة
  void clear() {
    _parentData = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}