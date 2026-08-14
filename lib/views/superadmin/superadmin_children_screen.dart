// lib/views/superadmin/superadmin_children_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/superadmin_children_provider.dart';
import '../../models/superadmin_child_model.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class SuperAdminChildrenScreen extends StatefulWidget {
  const SuperAdminChildrenScreen({super.key});

  @override
  State<SuperAdminChildrenScreen> createState() => _SuperAdminChildrenScreenState();
}

class _SuperAdminChildrenScreenState extends State<SuperAdminChildrenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuperAdminChildrenProvider>().fetchAllChildren();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SuperAdminChildrenProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('كل الأطفال', style: TextStyle(color: Colors.white)),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : provider.children.isEmpty
          ? const Center(child: Text('لا يوجد أطفال مسجلون'))
          : RefreshIndicator(
        onRefresh: () => provider.fetchAllChildren(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.children.length,
          itemBuilder: (context, index) {
            final child = provider.children[index];
            return _buildChildCard(child);
          },
        ),
      ),
    );
  }

  Widget _buildChildCard(SuperAdminChildModel child) {
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
                  'ولي الأمر: ${child.parentName} (${child.parentMobile})',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}