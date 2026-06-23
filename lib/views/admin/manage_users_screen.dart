import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  int _selectedTab = 0;

  final List<Map<String, String>> _parents = [
    {'name': 'أحمد', 'subtitle': 'Age 7 — Moderate ASD'},
    {'name': 'سارة', 'subtitle': 'Age 5 — Mild ASD'},
    {'name': 'محمد', 'subtitle': 'Age 9 — Severe ASD'},
  ];

  final List<Map<String, String>> _specialists = [
    {'name': 'Dr. Lina', 'subtitle': 'Speech Therapist'},
    {'name': 'Dr. Omar', 'subtitle': 'Behavioral Specialist'},
  ];

  @override
  Widget build(BuildContext context) {
    final users = _selectedTab == 0 ? _parents : _specialists;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),

      appBar: AppBar(
        title: const Text(
          'Manage Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Tabs
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD8E8FA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _tabButton('Parents', 0),
                  _tabButton('Specialists', 1),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Title + Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Active Directory',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5F9E),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF0FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD8E8FA)),
                  ),
                  child: Text(
                    '${users.length} Registered',
                    style: const TextStyle(
                      color: Color(0xFF2D5F9E),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Users List
            Expanded(
              child: ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD8E8FA)),
                    ),
                    child: Row(
                      children: [

                        // Avatar
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFFDFF0FF),
                          child: Text(
                            user['name']![0],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF2D5F9E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Name + Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D5F9E),
                                ),
                              ),
                              Text(
                                user['subtitle']!,
                                style: const TextStyle(
                                  color: Color(0xFFA0B4D0),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Edit
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Color(0xFF5B9EF5)),
                        ),

                        // Delete
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Color(0xFFDC2626)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Add Button
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: Text(_selectedTab == 0 ? 'Add Parent' : 'Add Specialist'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5B9EF5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF5B9EF5),
        unselectedItemColor: const Color(0xFFA0B4D0),
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 0) Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Content'),
        ],
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5B9EF5) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF2D5F9E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}