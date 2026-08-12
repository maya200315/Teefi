class ReportModel {
  final int childId;
  final DateTime periodStart;
  final DateTime periodEnd;
  final int totalBehaviors;
  final int positiveCount;
  final int negativeCount;
  final String summary;

  ReportModel({
    required this.childId,
    required this.periodStart,
    required this.periodEnd,
    required this.totalBehaviors,
    required this.positiveCount,
    required this.negativeCount,
    required this.summary,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      childId: json['Childid'],
      periodStart: DateTime.parse(json['week_start'] ?? json['month_start']),
      periodEnd: DateTime.parse(json['week_end'] ?? json['month_end']),
      totalBehaviors: json['total_behaviors'] ?? 0,
      positiveCount: json['positive_count'] ?? 0,
      negativeCount: json['negative_count'] ?? 0,
      summary: json['summary'] ?? '',
    );
  }
}

class ChartColumn {
  final String key;
  final String label;
  final int count;
  final double percentage;

  ChartColumn({
    required this.key,
    required this.label,
    required this.count,
    required this.percentage,
  });

  factory ChartColumn.fromJson(Map<String, dynamic> json) {
    return ChartColumn(
      key: json['key'],
      label: json['label'],
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}

class ChartDataModel {
  final String period;
  final String start;
  final String end;
  final int total;
  final List<ChartColumn> columns;

  ChartDataModel({
    required this.period,
    required this.start,
    required this.end,
    required this.total,
    required this.columns,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      period: json['period'],
      start: json['start'],
      end: json['end'],
      total: json['total'] ?? 0,
      columns: (json['columns'] as List)
          .map((c) => ChartColumn.fromJson(c))
          .toList(),
    );
  }
}

class RecommendationModel {
  final int id;
  final String text;
  final String date;
  final String specialistName;

  RecommendationModel({
    required this.id,
    required this.text,
    required this.date,
    required this.specialistName,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    String name = '';
    final user = json['user'];
    if (user is Map<String, dynamic>) {
      name = user['name'] ?? '';
    }

    return RecommendationModel(
      id: json['id'],
      text: json['text'] ?? '',
      date: json['date'] ?? '',
      specialistName: name,
    );
  }
}