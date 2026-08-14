// lib/providers/superadmin_articles_provider.dart

import 'package:flutter/material.dart';
import '../models/superadmin_article_model.dart';
import '../services/superadmin_articles_service.dart';

class SuperAdminArticlesProvider extends ChangeNotifier {
  final SuperAdminArticlesService _service = SuperAdminArticlesService();

  bool isLoading = false;
  String? errorMessage;
  List<SuperAdminArticleModel> articles = [];

  Future<void> fetchAllArticles() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      articles = await _service.getAllArticles();
    } catch (e) {
      errorMessage = 'تعذر تحميل المقالات';
    }

    isLoading = false;
    notifyListeners();
  }
}