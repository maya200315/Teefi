// lib/providers/superadmin_complaints_provider.dart

import 'package:flutter/material.dart';
import '../models/superadmin_complaint_model.dart';
import '../services/superadmin_complaints_service.dart';

class SuperAdminComplaintsProvider extends ChangeNotifier {
  final SuperAdminComplaintsService _service = SuperAdminComplaintsService();

  bool isLoading = false;
  String? errorMessage;
  List<SuperAdminComplaintModel> complaints = [];

  Future<void> fetchAllComplaints() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      complaints = await _service.getAllComplaints();
    } catch (e) {
      errorMessage = 'تعذر تحميل الشكاوي';
    }

    isLoading = false;
    notifyListeners();
  }
}