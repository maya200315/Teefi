// lib/models/superadmin_pecs_card_model.dart

class SuperAdminPecsCardModel {
  final int id;
  final String title;
  final String imageUrl;
  final int categoryId;

  SuperAdminPecsCardModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.categoryId,
  });

  factory SuperAdminPecsCardModel.fromJson(Map<String, dynamic> json) {
    return SuperAdminPecsCardModel(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      categoryId: json['PECS_card_categoryid'] ?? 0,
    );
  }
}