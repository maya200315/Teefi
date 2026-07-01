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
    // ✅ تحويل التاريخ
    String rawDate = json['datetime'] ?? '';
    String formattedDate = '';
    try {
      final dt = DateTime.parse(rawDate);
      formattedDate = '${dt.day}/${dt.month}/${dt.year}';
    } catch (e) {
      formattedDate = rawDate;
    }

    return ArticleModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      datetime: formattedDate,
    );
  }
}