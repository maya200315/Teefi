import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import 'superadmin_specialists_screen.dart';
import 'superadmin_pecs_screen.dart';
import 'superadmin_children_screen.dart';
import 'superadmin_complaints_screen.dart';
import 'superadmin_articles_screen.dart'; // ⬅️ جديد

class SuperAdminDashboardScreen extends StatelessWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('لوحة مدير المركز'),
        actions: [
          IconButton(
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.medical_services_outlined, color: AppColors.primary),
              title: const Text('الأخصائيون'),
              trailing: const Icon(Icons.arrow_back_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuperAdminSpecialistsScreen()),
                );
              },
            ),
            const SizedBox(height: 10), // ⬅️ جديد بدءاً من هون
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.menu_book_outlined, color: AppColors.primary),
              title: const Text('المكتبة الإرشادية'),
              trailing: const Icon(Icons.arrow_back_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuperAdminArticlesScreen()),
                );
              },
            ), // ⬅️ لحد هون الجزء الجديد
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.grid_view_outlined, color: AppColors.primary),
              title: const Text('بطاقات PECS'),
              trailing: const Icon(Icons.arrow_back_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuperAdminPecsScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.child_care_outlined, color: AppColors.primary),
              title: const Text('كل الأطفال'),
              trailing: const Icon(Icons.arrow_back_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuperAdminChildrenScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: const Icon(Icons.report_problem_outlined, color: AppColors.error),
              title: const Text('الشكاوي'),
              trailing: const Icon(Icons.arrow_back_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuperAdminComplaintsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}