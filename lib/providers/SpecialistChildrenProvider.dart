// lib/providers/specialist_children_provider.dart

import 'package:flutter/material.dart';
import '../models/specialist_children_model.dart';
import '../services/specialist_children_service.dart';

class SpecialistChildrenProvider extends ChangeNotifier {
  final SpecialistChildrenService _service = SpecialistChildrenService();

  SpecialistChildrenModel? data;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchMyChildren() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      data = await _service.getMyChildren();
    } catch (e) {
      errorMessage = 'تعذر تحميل قائمة الأطفال';
    }

    isLoading = false;
    notifyListeners();
  }
}