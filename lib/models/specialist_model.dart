class SpecialistModel {
  final int id;
  final int? specialistId; // ← أضيفي هاد
  final String name;
  final String mobileNumber;
  final String specialty;

  SpecialistModel({
    required this.id,
    this.specialistId, // ← وهاد
    required this.name,
    required this.mobileNumber,
    required this.specialty,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      specialistId: json['specialist']?['id'], // ← وهاد
      name: json['name'],
      mobileNumber: json['mobile_number'] ?? '',
      specialty: json['specialist']?['specialty'] ?? '',
    );
  }
}