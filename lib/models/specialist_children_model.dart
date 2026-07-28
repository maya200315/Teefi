// lib/models/specialist_children_model.dart

class SpecialistChildModel {
  final int id;
  final String name;
  final int age;
  final String autismLevel;
  final String parentName;

  SpecialistChildModel({
    required this.id,
    required this.name,
    required this.age,
    required this.autismLevel,
    required this.parentName,
  });

  factory SpecialistChildModel.fromJson(Map<String, dynamic> json) {
    return SpecialistChildModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      autismLevel: json['autism_level'] ?? '',
      parentName: json['parent_name'] ?? '',
    );
  }
}

class SpecialistChildrenModel {
  final String specialistName;
  final String specialty;
  final List<SpecialistChildModel> children;

  SpecialistChildrenModel({
    required this.specialistName,
    required this.specialty,
    required this.children,
  });

  factory SpecialistChildrenModel.fromJson(Map<String, dynamic> json) {
    return SpecialistChildrenModel(
      specialistName: json['specialist_name'] ?? '',
      specialty: json['specialty'] ?? '',
      children: (json['children'] as List)
          .map((c) => SpecialistChildModel.fromJson(c))
          .toList(),
    );
  }
}