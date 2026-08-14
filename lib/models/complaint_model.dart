// lib/models/complaint_model.dart

class ComplaintModel {
  final int id;
  final String title;
  final String message;

  ComplaintModel({
    required this.id,
    required this.title,
    required this.message,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
    );
  }
}