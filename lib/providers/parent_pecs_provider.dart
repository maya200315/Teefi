import 'package:flutter/material.dart';
import '../services/parent_pecs_service.dart';
import '../models/pecs_category_model.dart';

class ParentPecsProvider extends ChangeNotifier {
  final ParentPecsService _service = ParentPecsService();

  List<PecsCategoryModel> _categories = [];
  PecsCategoryModel? _selectedCategory;
  List<PecsCardModel> _cards = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PecsCategoryModel> get categories => _categories;
  PecsCategoryModel? get selectedCategory => _selectedCategory;
  List<PecsCardModel> get cards => _cards;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final data = await _service.getCategories();
      _categories = data.map((e) => PecsCategoryModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load categories';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategoryCards(int categoryId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await _service.getCategoryCards(categoryId);
      _selectedCategory = PecsCategoryModel.fromJson(result['category']);
      final list = result['data'] as List<dynamic>;
      _cards = list.map((e) => PecsCardModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load cards';
    }
    _isLoading = false;
    notifyListeners();
  }
}