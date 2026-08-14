// lib/providers/superadmin_pecs_provider.dart

import 'package:flutter/material.dart';
import '../models/superadmin_pecs_card_model.dart';
import '../services/superadmin_pecs_service.dart';

class SuperAdminPecsProvider extends ChangeNotifier {
  final SuperAdminPecsService _service = SuperAdminPecsService();

  bool isLoading = false;
  String? errorMessage;
  List<SuperAdminPecsCardModel> cards = [];

  Future<void> fetchAllPecsCards() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      cards = await _service.getAllPecsCards();
    } catch (e) {
      errorMessage = 'تعذر تحميل بطاقات PECS';
    }

    isLoading = false;
    notifyListeners();
  }
}