class SpecialistModel {
  final int id;
  final int? specialistId; //
  final String name;
  final String mobileNumber;
  final String specialty;

  SpecialistModel({
    required this.id,
    this.specialistId, //
    required this.name,
    required this.mobileNumber,
    required this.specialty,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      specialistId: json['specialist']?['id'], //
      name: json['name'],
      mobileNumber: json['mobile_number'] ?? '',
      specialty: json['specialist']?['specialty'] ?? '',
    );
  }
}