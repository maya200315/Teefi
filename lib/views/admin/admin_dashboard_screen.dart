import 'package:flutter/material.dart';
import 'package:teefi/views/admin/manage_users_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),

      appBar: AppBar(
        title: const Text(
          'Teefi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Admin Dashboard',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5F9E),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Welcome back, managing the community today.',
              style: TextStyle(color: Color(0xFFA0B4D0)),
            ),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,

              children: const [

                _StatCard(
                  title: 'Parents',
                  count: '12',
                  icon: Icons.people,
                ),

                _StatCard(
                  title: 'Specialists',
                  count: '5',
                  icon: Icons.medical_services,
                ),

                _StatCard(
                  title: 'Articles',
                  count: '24',
                  icon: Icons.article,
                ),

                _StatCard(
                  title: 'PECS Cards',
                  count: '48',
                  icon: Icons.style,
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5F9E),
              ),
            ),

            const SizedBox(height: 15),

            _actionButton(
              context: context,
              icon: Icons.person_add,
              text: 'Manage Users',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageUsersScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _actionButton(
              context: context,
              icon: Icons.edit_document,
              text: 'Manage Articles',
              onPressed: () {},
            ),

            const SizedBox(height: 12),

            _actionButton(
              context: context,
              icon: Icons.grid_view,
              text: 'Manage PECS Cards',
              onPressed: () {},
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF5B9EF5),
        unselectedItemColor: const Color(0xFFA0B4D0),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Content'),
        ],
      ),
    );
  }

  static Widget _actionButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9EF5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFD8E8FA)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Icon(Icons.people, color: Color(0xFF5B9EF5)),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(color: Color(0xFFA0B4D0)),
            ),

            Text(
              count,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5F9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}