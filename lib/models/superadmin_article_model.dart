// lib/models/superadmin_article_model.dart

class SuperAdminArticleModel {
  final int id;
  final String title;
  final String content;
  final String datetime;
  final String authorName;

  SuperAdminArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.datetime,
    required this.authorName,
  });

  factory SuperAdminArticleModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return SuperAdminArticleModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      datetime: json['datetime'] ?? '',
      authorName: user?['name'] ?? '',
    );
  }
}