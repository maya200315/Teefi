import 'package:flutter/material.dart';
import '../services/article_service.dart';
import '../models/article_model.dart';

class ContentProvider extends ChangeNotifier {
  final ArticleService _articleService = ArticleService();

  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;
  ArticleModel? _selectedArticle;

  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ArticleModel? get selectedArticle => _selectedArticle;

  // جلب مقالات الأدمن
  Future<void> fetchArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _articleService.getArticles();
      _articles = data.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load articles';
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ جلب مقالات الأهل
  Future<void> fetchUserArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _articleService.getUserArticles();
      _articles = data.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Failed to load articles';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchArticle(int id) async {
    try {
      final data = await _articleService.getArticle(id);
      _selectedArticle = ArticleModel.fromJson(data);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to load article";
      notifyListeners();
      return false;
    }
  }

  Future<bool> createArticle({
    required String title,
    required String content,
    required String datetime,
  }) async {
    try {
      await _articleService.createArticle(
          title: title, content: content, datetime: datetime);
      await fetchArticles();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create article';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateArticle({
    required int id,
    required String title,
    required String content,
  }) async {
    try {
      await _articleService.updateArticle(
          id: id, title: title, content: content);
      await fetchArticles();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update article';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteArticle(int id) async {
    try {
      await _articleService.deleteArticle(id);
      await fetchArticles();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete article';
      notifyListeners();
      return false;
    }
  }

  List<String> _pecsCategories = [
    'Food', 'Play', 'Routine', 'Emotions', 'School',
  ];

  List<String> get pecsCategories => _pecsCategories;

  void addCategory(String name) {
    _pecsCategories.add(name);
    notifyListeners();
  }

  void updateCategory(int index, String name) {
    _pecsCategories[index] = name;
    notifyListeners();
  }

  void deleteCategory(int index) {
    _pecsCategories.removeAt(index);
    notifyListeners();
  }
}