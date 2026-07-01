class ParentHomeModel {
  final int childId;
  final String childName;
  final int childAge;
  final String autismLevel;

  ParentHomeModel({
    required this.childId,
    required this.childName,
    required this.childAge,
    required this.autismLevel,
  });

  factory ParentHomeModel.fromJson(Map<String, dynamic> json) {
    final child = json['child'] as Map<String, dynamic>;
    return ParentHomeModel(
      childId: child['id'],
      childName: child['name'],
      childAge: child['age'],
      autismLevel: child['autism_level'] ?? '',
    );
  }
}