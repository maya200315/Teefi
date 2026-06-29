import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/parents_service.dart';
import '../models/parent_model.dart';

class ParentsProvider extends ChangeNotifier {
  final ParentsService _service = ParentsService();

  List<ParentModel> _parents = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ParentModel> get parents => _parents;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchParents() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _service.getParents();
      _parents = data.map((e) => ParentModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load parents';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createParent({
    required String name,
    required String mobileNumber,
    required String password,
    required String autismLevel,
    required int specialistId,
    int? age,
  }) async {
    try {
      await _service.createParent(
        name: name,
        mobileNumber: mobileNumber,
        password: password,
        autismLevel: autismLevel,
        specialistId: specialistId,
        age: age,
      );
      await fetchParents();
      return true;
    } catch (e) {
      // ✅ اطبعي التفاصيل
      if (e is DioException && e.response != null) {
        print('ERROR BODY: ${e.response?.data}');
      }
      print('CREATE PARENT ERROR: $e');
      _errorMessage = 'Failed to create parent';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateParent({
    required int id,
    required String name,
    required String mobileNumber,
    String? password,
  }) async {
    try {
      await _service.updateParent(
        id: id,
        name: name,
        mobileNumber: mobileNumber,
        password: password,
      );
      await fetchParents();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update parent';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteParent(int id) async {
    try {
      await _service.deleteParent(id);
      await fetchParents();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete parent';
      notifyListeners();
      return false;
    }
  }
}