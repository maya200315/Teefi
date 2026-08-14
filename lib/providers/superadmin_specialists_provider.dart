// lib/providers/superadmin_specialists_provider.dart

import 'package:flutter/material.dart';
import '../models/superadmin_specialist_model.dart';
import '../models/specialist_children_model.dart';
import '../services/superadmin_specialists_service.dart';

class SuperAdminSpecialistsProvider extends ChangeNotifier {
  final SuperAdminSpecialistsService _service = SuperAdminSpecialistsService();

  bool isLoading = false;
  String? errorMessage;
  List<SuperAdminSpecialistModel> specialists = [];

  bool isLoadingChildren = false;
  String? childrenErrorMessage;
  List<SpecialistChildModel> selectedSpecialistChildren = [];

  Future<void> fetchAllSpecialists() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      specialists = await _service.getAllSpecialists();
    } catch (e) {
      errorMessage = 'تعذر تحميل قائمة الأخصائيين';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchChildrenForSpecialist(int specialistId) async {
    isLoadingChildren = true;
    childrenErrorMessage = null;
    selectedSpecialistChildren = [];
    notifyListeners();

    try {
      selectedSpecialistChildren = await _service.getChildrenForSpecialist(specialistId);
    } catch (e) {
      childrenErrorMessage = 'تعذر تحميل قائمة الأطفال';
    }

    isLoadingChildren = false;
    notifyListeners();
  }
}