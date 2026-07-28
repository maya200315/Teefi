import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/SpecialistChildrenProvider.dart';
import '../../providers/auth_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../auth/login_screen.dart'; // تأكدي من ضبط المسار حسب مجلدات مشروعك

class SpecialistChildrenScreen extends StatefulWidget {
  const SpecialistChildrenScreen({super.key});

  @override
  State<SpecialistChildrenScreen> createState() => _SpecialistChildrenScreenState();
}

class _SpecialistChildrenScreenState extends State<SpecialistChildrenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpecialistChildrenProvider>().fetchMyChildren();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpecialistChildrenProvider>();
    final data = provider.data;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(data?.specialistName ?? '', data?.specialty ?? ''),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                ? Center(child: Text(provider.errorMessage!))
                : data == null || data.children.isEmpty
                ? const Center(child: Text('لا يوجد أطفال مسجلين حالياً'))
                : RefreshIndicator(
              onRefresh: () => provider.fetchMyChildren(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.children.length,
                itemBuilder: (context, index) {
                  final child = data.children[index];
                  return _buildChildCard(child);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String specialistName, String specialty) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 8, right: 8),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                specialistName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                specialty,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(dynamic child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () {
          // TODO: هنربطها بشاشة تفاصيل الطفل لما نجهزها بكرا
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
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
                  ],
                ),
              ),
              Icon(Icons.arrow_back_ios, size: 16, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}