import 'package:flutter/material.dart';
import '../services/pecs_service.dart';
import '../models/pecs_category_model.dart';

class PecsProvider extends ChangeNotifier {
  final PecsService _pecsService = PecsService();

  //State
  List<PecsCategoryModel> _categories = [];
  PecsCategoryModel? _selectedCategory;
  PecsCardModel? _selectedCard;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<PecsCategoryModel> get categories => _categories;
  PecsCategoryModel? get selectedCategory => _selectedCategory;
  PecsCardModel? get selectedCard => _selectedCard;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  //Categories

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _pecsService.getCategories();
      _categories = data.map((e) => PecsCategoryModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load categories';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchCategory(int id) async {
    try {
      final data = await _pecsService.getCategory(id);
      _selectedCategory = PecsCategoryModel.fromJson(data);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load category';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createCategory({required String name}) async {
    try {
      await _pecsService.createCategory(name: name);
      await fetchCategories();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create category';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCategory({required int id, required String name}) async {
    try {
      await _pecsService.updateCategory(id: id, name: name);
      await fetchCategories();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update category';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      await _pecsService.deleteCategory(id);
      await fetchCategories();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete category';
      notifyListeners();
      return false;
    }
  }

  // ─── Cards

  Future<bool> fetchCard(int id) async {
    try {
      final data = await _pecsService.getCard(id);
      _selectedCard = PecsCardModel.fromJson(data);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load card';
      notifyListeners();
      return false;
    }
  }

  Future<bool> createCard({
    required String title,
    required int categoryId,
    required String imagePath,
  }) async {
    try {
      await _pecsService.createCard(
        title: title,
        categoryId: categoryId,
        imagePath: imagePath,
      );
      await fetchCategory(categoryId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create card';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCard({
    required int id,
    required String title,
    required int categoryId,
    String? imagePath,
  }) async {
    try {
      await _pecsService.updateCard(
        id: id,
        title: title,
        categoryId: categoryId,
        imagePath: imagePath,
      );
      await fetchCategory(categoryId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update card';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCard({required int cardId, required int categoryId}) async {
    try {
      await _pecsService.deleteCard(cardId);
      await fetchCategory(categoryId);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete card';
      notifyListeners();
      return false;
    }
  }
}