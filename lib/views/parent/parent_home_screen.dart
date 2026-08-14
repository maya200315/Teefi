import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teefi/providers/auth_provider.dart';
import 'package:teefi/providers/parent_home_provider.dart';
import 'package:teefi/views/auth/login_screen.dart';
import 'package:teefi/views/parent/parent_library_screen.dart';
import 'package:teefi/views/parent/parent_pecs_screen.dart';
import 'package:teefi/views/parent/parent_report_screen.dart';
import 'package:teefi/views/parent/record_behavior_screen.dart';
import 'package:teefi/views/parent/parent_complaint_screen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ParentHomeProvider>().fetchHomeData());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParentHomeProvider>();
    final data = provider.homeData;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // ── Header ──────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF5B9EF5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ✅ زر اللوغ أوت
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    await context.read<AuthProvider>().logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                            (route) => false,
                      );
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Welcome • أهلاً',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data?.childName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Child Card ───────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5B9EF5)
                              .withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF0FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              data?.childName.isNotEmpty == true
                                  ? data!.childName[0]
                                  : '?',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF5B9EF5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.childName ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D5F9E),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Age ${data?.childAge ?? ''} • ${data?.autismLevel ?? ''}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFA0B4D0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D5F9E),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Active ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.check,
                                  color: Colors.white, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Quick Actions ────────────────────────
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5F9E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _quickAction(
                          icon: Icons.assignment_outlined,
                          label: 'Behavior',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RecordBehaviorScreen()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _quickAction(
                          icon: Icons.bar_chart_outlined,
                          label: 'Reports',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ParentReportScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        _quickAction(
                          icon: Icons.style_outlined,
                          label: 'PECS',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ParentPecsScreen()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _quickAction(
                          icon: Icons.menu_book_outlined,
                          label: 'Library',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ParentLibraryScreen()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _quickAction(
                          icon: Icons.report_problem_outlined,
                          label: 'Complaint',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ParentComplaintScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: const Color(0xFF5B9EF5),
        unselectedItemColor: const Color(0xFFA0B4D0),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.style_outlined), label: 'PECS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), label: 'Behavior'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFDFF0FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child:
            Icon(icon, color: const Color(0xFF5B9EF5), size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2D5F9E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}