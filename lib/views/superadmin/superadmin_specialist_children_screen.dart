// lib/views/superadmin/superadmin_specialist_children_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/superadmin_specialists_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class SuperAdminSpecialistChildrenScreen extends StatefulWidget {
  final int specialistId;
  final String specialistName;

  const SuperAdminSpecialistChildrenScreen({
    super.key,
    required this.specialistId,
    required this.specialistName,
  });

  @override
  State<SuperAdminSpecialistChildrenScreen> createState() =>
      _SuperAdminSpecialistChildrenScreenState();
}

class _SuperAdminSpecialistChildrenScreenState extends State<SuperAdminSpecialistChildrenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuperAdminSpecialistsProvider>().fetchChildrenForSpecialist(widget.specialistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SuperAdminSpecialistsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.specialistName, style: const TextStyle(color: Colors.white)),
      ),
      body: provider.isLoadingChildren
          ? const Center(child: CircularProgressIndicator())
          : provider.childrenErrorMessage != null
          ? Center(child: Text(provider.childrenErrorMessage!))
          : provider.selectedSpecialistChildren.isEmpty
          ? const Center(child: Text('لا يوجد أطفال مسندين لهذا الأخصائي'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.selectedSpecialistChildren.length,
        itemBuilder: (context, index) {
          final child = provider.selectedSpecialistChildren[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    child.name.isNotEmpty ? child.name[0] : '?',
                    style: AppTextStyles.heading2,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name, style: AppTextStyles.heading2),
                      const SizedBox(height: 4),
                      Text(
                        'Age ${child.age} • ${child.autismLevel} ASD',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ولي الأمر: ${child.parentName}',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}