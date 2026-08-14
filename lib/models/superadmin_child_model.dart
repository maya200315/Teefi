// lib/models/superadmin_child_model.dart

class SuperAdminChildModel {
  final int id;
  final String name;
  final int age;
  final String autismLevel;
  final String parentName;
  final String parentMobile;

  SuperAdminChildModel({
    required this.id,
    required this.name,
    required this.age,
    required this.autismLevel,
    required this.parentName,
    required this.parentMobile,
  });

  factory SuperAdminChildModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return SuperAdminChildModel(
      id: json['id'],
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      autismLevel: json['autism_level'] ?? '',
      parentName: user?['name'] ?? '',
      parentMobile: user?['mobile_number'] ?? '',
    );
  }
}