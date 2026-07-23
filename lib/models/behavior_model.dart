class ChildBriefModel {
  final int id;
  final String name;

  ChildBriefModel({required this.id, required this.name});

  factory ChildBriefModel.fromJson(Map<String, dynamic> json) {
    return ChildBriefModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

class ChildProfileModel {
  final int id;
  final String name;
  final int age;
  final String autismLevel;

  ChildProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.autismLevel,
  });

  factory ChildProfileModel.fromJson(Map<String, dynamic> json) {
    return ChildProfileModel(
      id: json['id'],
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      autismLevel: json['autism_level'] ?? '',
    );
  }
}

class BehaviorTypeModel {
  final int id;
  final String name;

  BehaviorTypeModel({required this.id, required this.name});

  factory BehaviorTypeModel.fromJson(Map<String, dynamic> json) {
    return BehaviorTypeModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}