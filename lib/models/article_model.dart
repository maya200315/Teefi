class ArticleModel {
  final int id;
  final String title;
  final String content;
  final String datetime;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.datetime,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      datetime: json['datetime'] ?? '',
    );
  }
}