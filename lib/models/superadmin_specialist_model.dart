// lib/models/superadmin_specialist_model.dart

class SuperAdminSpecialistModel {
  final int id;
  final String specialty;
  final String name;
  final String mobileNumber;

  SuperAdminSpecialistModel({
    required this.id,
    required this.specialty,
    required this.name,
    required this.mobileNumber,
  });

  factory SuperAdminSpecialistModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return SuperAdminSpecialistModel(
      id: json['id'],
      specialty: json['specialty'] ?? '',
      name: user?['name'] ?? '',
      mobileNumber: user?['mobile_number'] ?? '',
    );
  }
}