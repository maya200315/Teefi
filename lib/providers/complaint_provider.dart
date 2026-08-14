// lib/providers/complaint_provider.dart

import 'package:flutter/material.dart';
import '../services/complaint_service.dart';

class ComplaintProvider extends ChangeNotifier {
  final ComplaintService _service = ComplaintService();

  bool isSubmitting = false;
  String? errorMessage;
  bool submitSuccess = false;

  Future<bool> submitComplaint(String title, String message) async {
    isSubmitting = true;
    errorMessage = null;
    submitSuccess = false;
    notifyListeners();

    bool success = false;
    try {
      await _service.submitComplaint(title, message);
      success = true;
      submitSuccess = true;
    } catch (e) {
      errorMessage = 'تعذر إرسال الشكوى، حاولي مرة أخرى';
    }

    isSubmitting = false;
    notifyListeners();
    return success;
  }

  void resetState() {
    submitSuccess = false;
    errorMessage = null;
    notifyListeners();
  }
}