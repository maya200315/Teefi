import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/report_provider.dart';
import '../../providers/parent_home_provider.dart';
import '../../models/report_model.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class ParentReportScreen extends StatefulWidget {
  const ParentReportScreen({super.key});

  @override
  State<ParentReportScreen> createState() => _ParentReportScreenState();
}

class _ParentReportScreenState extends State<ParentReportScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeData = context.read<ParentHomeProvider>().homeData;
      if (homeData != null) {
        context.read<ReportProvider>().loadReports(homeData.childId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = context.watch<ReportProvider>();
    final homeData = context.watch<ParentHomeProvider>().homeData;
    final childId = homeData?.childId;
    final childName = homeData?.childName ?? '';

    if (homeData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Column(
          children: [
            const Text('Progress Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(childName, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
        centerTitle: true,
      ),
      body: reportProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : reportProvider.errorMessage != null
          ? Center(child: Text(reportProvider.errorMessage!))
          : RefreshIndicator(
        onRefresh: () async {
          if (childId != null) {
            await reportProvider.loadReports(childId);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPeriodToggle(context, childId),
              const SizedBox(height: 16),
              _buildChartCard(reportProvider),
              const SizedBox(height: 16),
              _buildSummaryCard(
                title: 'Weekly Summary',
                icon: Icons.calendar_today,
                iconColor: AppColors.primary,
                summary: reportProvider.weeklyReport?.summary ?? '',
              ),
              const SizedBox(height: 12),
              _buildSummaryCard(
                title: 'Monthly Summary',
                icon: Icons.bar_chart,
                iconColor: Colors.orange,
                summary: reportProvider.monthlyReport?.summary ?? '',
              ),
              const SizedBox(height: 16),
              _buildRecommendationsSection(reportProvider.recommendations),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodToggle(BuildContext context, int? childId) {
    final provider = context.watch<ReportProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.cardBorder),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _toggleButton(
              label: 'Monthly',
              selected: provider.selectedPeriod == 'monthly',
              onTap: () {
                if (childId != null) {
                  context.read<ReportProvider>().switchPeriod(childId, 'monthly');
                }
              },
            ),
          ),
          Expanded(
            child: _toggleButton(
              label: 'Weekly',
              selected: provider.selectedPeriod == 'weekly',
              onTap: () {
                if (childId != null) {
                  context.read<ReportProvider>().switchPeriod(childId, 'weekly');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({required String label, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(ReportProvider provider) {
    final chart = provider.chartData;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معدل السلوكيات', style: AppTextStyles.heading2),
          const SizedBox(height: 16),
          if (chart == null)
            const SizedBox(height: 180, child: Center(child: Text('لا توجد بيانات')))
          else
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 25,
                        getTitlesWidget: (value, meta) => Text('${value.toInt()}%', style: AppTextStyles.bodySmall),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= chart.columns.length) return const SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(chart.columns[index].label, style: AppTextStyles.bodySmall),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: List.generate(chart.columns.length, (i) {
                    final col = chart.columns[i];
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: col.percentage,
                          color: _colorForKey(col.key),
                          width: 28,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          const SizedBox(height: 16),
          _buildLegend(),
        ],
      ),
    );
  }

  Color _colorForKey(String key) {
    switch (key) {
      case 'positive':
        return AppColors.success;
      case 'anger':
        return AppColors.error;
      case 'repetitive':
        return Colors.amber;
      case 'response':
        return AppColors.primary;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend() {
    final items = [
      ('تفاعل إيجابي (Positive)', AppColors.success),
      ('نوبة غضب (Anger Episode)', AppColors.error),
      ('سلوك تكراري (Repetitive)', Colors.amber),
      ('استجابة (Response)', AppColors.primary),
    ];
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: items.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(color: item.$2, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(item.$1, style: AppTextStyles.bodySmall),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String summary,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Text(
                  summary.isEmpty ? '...' : summary,
                  style: AppTextStyles.bodyLarge,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          Icon(icon, color: iconColor),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection(List<RecommendationModel> recommendations) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('توصيات الأخصائي', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          ...recommendations.map((rec) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.medical_services_outlined, size: 16, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        rec.specialistName.isEmpty ? 'الأخصائي' : rec.specialistName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    rec.text,
                    style: AppTextStyles.bodyLarge,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Text(rec.date, style: AppTextStyles.bodySmall),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}