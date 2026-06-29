class ParentModel {
  final int id;
  final String name;
  final String mobileNumber;
  final String createdAt;
  final String? autismLevel;
  final int? age;
  final int? specialistId;

  ParentModel({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.createdAt,
    this.autismLevel,
    this.age,
    this.specialistId,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    final parentt = json['parentt'] as Map<String, dynamic>?;
    return ParentModel(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobile_number'] ?? '',
      createdAt: json['created_at'] ?? '',
      autismLevel: parentt?['autism_level'],
      age: parentt?['age'],
      specialistId: parentt?['specialist_id'],
    );
  }
}