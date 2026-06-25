import 'package:flutter/material.dart';
import 'package:teefi/services/parents_service.dart';
import 'Add Users/add_parent_screen.dart';
import 'Add Users/add_specialist_screen.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  int _selectedTab = 0;

  final ParentsService _parentsService = ParentsService();
  List parents = [];
  bool isLoading = true;

  final List<Map<String, String>> _specialists = [
    {'name': 'Dr. Lina', 'subtitle': 'Speech Therapist'},
    {'name': 'Dr. Omar', 'subtitle': 'Behavioral Specialist'},
  ];

  @override
  void initState() {
    super.initState();
    _loadParents();
  }

  void _loadParents() async {
    setState(() => isLoading = true);

    try {
      final data = await _parentsService.getParents();
      setState(() {
        parents = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading parents: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isParentsTab = _selectedTab == 0;

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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF0FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD8E8FA)),
                  ),
                  child: Text(
                    isParentsTab
                        ? '${parents.length} Registered'
                        : '${_specialists.length} Registered',
                    style: const TextStyle(
                      color: Color(0xFF2D5F9E),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: isParentsTab
                  ? _buildParentsList()
                  : _buildSpecialistsList(),
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
            onPressed: () async {
              if (_selectedTab == 0) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddParentScreen(),
                  ),
                );

                if (result == true) {
                  _loadParents();
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSpecialistScreen(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: Text(
              _selectedTab == 0 ? 'Add Parent' : 'Add Specialist',
            ),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article), label: 'Content'),
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

  // ---------------- PARENTS ----------------

  Widget _buildParentsList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (parents.isEmpty) {
      return const Center(
        child: Text(
          "No Parents Found",
          style: TextStyle(color: Color(0xFFA0B4D0)),
        ),
      );
    }

    return ListView.separated(
      itemCount: parents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final parent = parents[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD8E8FA)),
          ),
          child: Row(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFDFF0FF),
                child: Text(
                  (parent['name'] ?? '?')[0],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2D5F9E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // ✅ FIXED
                  children: [
                    Text(
                      parent['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5F9E),
                      ),
                    ),
                    Text(
                      parent['mobile_number'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFFA0B4D0),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF5B9EF5)),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddParentScreen(
                        parentData: {
                          'id': parent['id'].toString(),
                        },
                      ),
                    ),
                  );

                  if (result == true) {
                    _loadParents();
                  }
                },
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFDC2626)),
                onPressed: () {
                  setState(() {
                    parents.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- SPECIALISTS ----------------

  Widget _buildSpecialistsList() {
    return ListView.separated(
      itemCount: _specialists.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = _specialists[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD8E8FA)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user['name'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D5F9E),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF5B9EF5)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddSpecialistScreen(
                        specialistData: {
                          'name': user['name'],
                          'email': 'specialist@test.com',
                          'password': '123456',
                          'specialty': user['subtitle'] ?? '',
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}