class PecsCategoryModel {
  final int id;
  final String name;
  final List<PecsCardModel> pecsCards;

  PecsCategoryModel({
    required this.id,
    required this.name,
    required this.pecsCards,
  });

  factory PecsCategoryModel.fromJson(Map<String, dynamic> json) {
    return PecsCategoryModel(
      id: json['id'],
      name: json['name'],
      pecsCards: (json['pecs_cards'] as List<dynamic>? ?? [])
          .map((e) => PecsCardModel.fromJson(e))
          .toList(),
    );
  }
}

class PecsCardModel {
  final int id;
  final String title;
  final String image;
  final String imageUrl;
  final int categoryId;

  PecsCardModel({
    required this.id,
    required this.title,
    required this.image,
    required this.imageUrl,
    required this.categoryId,
  });

  factory PecsCardModel.fromJson(Map<String, dynamic> json) {
    return PecsCardModel(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      imageUrl: json['image_url'] ?? '',
      categoryId: json['PECS_card_category_id'] is int
          ? json['PECS_card_category_id']
          : int.tryParse(json['PECS_card_category_id'].toString()) ?? 0,
    );
  }
}