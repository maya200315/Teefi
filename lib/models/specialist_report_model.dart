// lib/models/specialist_report_model.dart

class ParentNoteModel {
  final String date;
  final String? type;
  final String notes;
  final String? author;

  ParentNoteModel({
    required this.date,
    required this.type,
    required this.notes,
    required this.author,
  });

  factory ParentNoteModel.fromJson(Map<String, dynamic> json) {
    return ParentNoteModel(
      date: json['date'] ?? '',
      type: json['type'],
      notes: json['notes'] ?? '',
      author: json['author'],
    );
  }
}

class SpecialistReportModel {
  final int childId;
  final DateTime periodStart;
  final DateTime periodEnd;
  final int totalBehaviors;
  final int positiveCount;
  final int negativeCount;
  final String summary;
  final List<ParentNoteModel> parentNotes;

  SpecialistReportModel({
    required this.childId,
    required this.periodStart,
    required this.periodEnd,
    required this.totalBehaviors,
    required this.positiveCount,
    required this.negativeCount,
    required this.summary,
    required this.parentNotes,
  });

  // ⚠️ بياخد الـ response الكامل (فيه status/data/parent_notes سوا)
  // مش بس response['data'] زي قبل
  factory SpecialistReportModel.fromJson(Map<String, dynamic> response) {
    final data = response['data'] as Map<String, dynamic>;
    final notesRaw = response['parent_notes'] as List?;

    final notesList = notesRaw
        ?.whereType<Map<String, dynamic>>()
        .map((n) => ParentNoteModel.fromJson(n))
        .toList() ??
        <ParentNoteModel>[];

    return SpecialistReportModel(
      childId: data['Childid'],
      periodStart: DateTime.parse(data['week_start'] ?? data['month_start']),
      periodEnd: DateTime.parse(data['week_end'] ?? data['month_end']),
      totalBehaviors: data['total_behaviors'] ?? 0,
      positiveCount: data['positive_count'] ?? 0,
      negativeCount: data['negative_count'] ?? 0,
      summary: data['summary'] ?? '',
      parentNotes: notesList,
    );
  }
}