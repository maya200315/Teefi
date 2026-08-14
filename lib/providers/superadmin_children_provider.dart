// lib/providers/superadmin_children_provider.dart

import 'package:flutter/material.dart';
import '../models/superadmin_child_model.dart';
import '../services/superadmin_children_service.dart';

class SuperAdminChildrenProvider extends ChangeNotifier {
  final SuperAdminChildrenService _service = SuperAdminChildrenService();

  bool isLoading = false;
  String? errorMessage;
  List<SuperAdminChildModel> children = [];

  Future<void> fetchAllChildren() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      children = await _service.getAllChildren();
    } catch (e) {
      errorMessage = 'تعذر تحميل قائمة الأطفال';
    }

    isLoading = false;
    notifyListeners();
  }
}