import 'package:flutter/material.dart';
import '../services/specialist_service.dart';
import '../models/specialist_model.dart';

class SpecialistsProvider extends ChangeNotifier {
  final SpecialistService _service = SpecialistService();

  List<SpecialistModel> _specialists = [];
  SpecialistModel? _selectedSpecialist;
  bool _isLoading = false;
  String? _errorMessage;

  List<SpecialistModel> get specialists => _specialists;
  SpecialistModel? get selectedSpecialist => _selectedSpecialist;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSpecialists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _service.getSpecialists();
      _specialists = data.map((e) => SpecialistModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load specialists';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchSpecialist(int id) async {
    try {
      final data = await _service.getSpecialist(id);
      _selectedSpecialist = SpecialistModel.fromJson(data);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load specialist';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createSpecialist({
    required String name,
    required String mobileNumber,
    required String password,
    required String specialty,
  }) async {
    try {
      await _service.createSpecialist(
        name: name,
        mobileNumber: mobileNumber,
        password: password,
        specialty: specialty,
      );
      await fetchSpecialists();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create specialist';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSpecialist({
    required int id,
    required String name,
    required String mobileNumber,
    required String specialty,
    String? password,
  }) async {
    try {
      await _service.updateSpecialist(
        id: id,
        name: name,
        mobileNumber: mobileNumber,
        specialty: specialty,
        password: password,
      );
      await fetchSpecialists();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update specialist';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSpecialist(int id) async {
    try {
      await _service.deleteSpecialist(id);
      await fetchSpecialists();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete specialist';
      notifyListeners();
      return false;
    }
  }
}