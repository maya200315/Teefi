// lib/views/specialist/specialist_child_report_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/specialist_report_provider.dart';
import '../../models/specialist_report_model.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class SpecialistChildReportScreen extends StatefulWidget {
  final int childId;
  final String childName;

  const SpecialistChildReportScreen({
    super.key,
    required this.childId,
    required this.childName,
  });

  @override
  State<SpecialistChildReportScreen> createState() => _SpecialistChildReportScreenState();
}

class _SpecialistChildReportScreenState extends State<SpecialistChildReportScreen> {
  final TextEditingController _recommendationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpecialistReportProvider>().loadReports(widget.childId);
    });
  }

  @override
  void dispose() {
    _recommendationController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveRecommendation() async {
    final text = _recommendationController.text.trim();
    if (text.isEmpty) return;

    final success = await context.read<SpecialistReportProvider>().saveRecommendation(
      widget.childId,
      text,
    );

    if (!mounted) return;

    if (success) {
      _recommendationController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ التوصية')),
      );
    } else {
      final error = context.read<SpecialistReportProvider>().recommendationError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'تعذر حفظ التوصية')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpecialistReportProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.errorMessage != null
                  ? Center(child: Text(provider.errorMessage!))
                  : RefreshIndicator(
                onRefresh: () => provider.loadReports(widget.childId),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPeriodToggle(provider),
                      const SizedBox(height: 16),
                      _buildChartCard(provider),
                      const SizedBox(height: 16),
                      _buildSummaryCard(
                        title: 'Weekly Summary',
                        icon: Icons.calendar_today,
                        iconColor: AppColors.primary,
                        report: provider.weeklyReport,
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryCard(
                        title: 'Monthly Summary',
                        icon: Icons.bar_chart,
                        iconColor: Colors.orange,
                        report: provider.monthlyReport,
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendationBox(provider),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Progress Report',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  widget.childName,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildPeriodToggle(SpecialistReportProvider provider) {
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
              onTap: () => provider.switchPeriod(widget.childId, 'monthly'),
            ),
          ),
          Expanded(
            child: _toggleButton(
              label: 'Weekly',
              selected: provider.selectedPeriod == 'weekly',
              onTap: () => provider.switchPeriod(widget.childId, 'weekly'),
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

  Widget _buildChartCard(SpecialistReportProvider provider) {
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
    required SpecialistReportModel? report,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  (report?.summary.isEmpty ?? true) ? '...' : report!.summary,
                  style: AppTextStyles.bodyLarge,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(title, style: AppTextStyles.heading2),
                  const SizedBox(height: 4),
                  Icon(icon, color: iconColor),
                ],
              ),
            ],
          ),
          if (report != null && report.parentNotes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.cardBorder),
            const SizedBox(height: 8),
            const Text('ملاحظات الأهل', style: AppTextStyles.label),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: report.parentNotes.map((note) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (note.type != null)
                        Text(
                          note.type!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      const SizedBox(height: 4),
                      Text(
                        note.notes,
                        style: AppTextStyles.bodyLarge,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${note.author ?? ''} • ${note.date}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecommendationBox(SpecialistReportProvider provider) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Add Recommendation', style: AppTextStyles.heading2),
              const Icon(Icons.edit_note, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _recommendationController,
            maxLines: 3,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'Write your therapeutic recommendation here',
              hintStyle: AppTextStyles.bodySmall,
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: provider.isSavingRecommendation ? null : _handleSaveRecommendation,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: provider.isSavingRecommendation
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                'حفظ التوصية • Save Recommendation',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}