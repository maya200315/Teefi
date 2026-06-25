class ParentModel {
  final int id;
  final String name;
  final String mobileNumber;
  final String createdAt;

  ParentModel({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.createdAt,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobile_number'],
      createdAt: json['created_at'],
    );
  }
}