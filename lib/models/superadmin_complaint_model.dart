// lib/models/superadmin_complaint_model.dart

class SuperAdminComplaintModel {
  final int id;
  final String title;
  final String message;
  final String createdAt;
  final String senderName;
  final String senderMobile;
  final int senderRoleId;

  SuperAdminComplaintModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.senderName,
    required this.senderMobile,
    required this.senderRoleId,
  });

  factory SuperAdminComplaintModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return SuperAdminComplaintModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? '',
      senderName: user?['name'] ?? '',
      senderMobile: user?['mobile_number'] ?? '',
      senderRoleId: user?['Roleid'] ?? 0,
    );
  }
}