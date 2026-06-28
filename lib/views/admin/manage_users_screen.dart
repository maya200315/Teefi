import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teefi/providers/parents_provider.dart';
import 'package:teefi/providers/specialists_provider.dart';
import 'package:teefi/models/specialist_model.dart';
import 'Add Users/add_parent_screen.dart';
import 'Add Users/add_specialist_screen.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ParentsProvider>().fetchParents();
      context.read<SpecialistsProvider>().fetchSpecialists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentsProvider = context.watch<ParentsProvider>();
    final specialistsProvider = context.watch<SpecialistsProvider>();
    final isParentsTab = _selectedTab == 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: const Text('Manage Users', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Active Directory',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D5F9E))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF0FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD8E8FA)),
                  ),
                  child: Text(
                    isParentsTab
                        ? '${parentsProvider.parents.length} Registered'
                        : '${specialistsProvider.specialists.length} Registered',
                    style: const TextStyle(color: Color(0xFF2D5F9E), fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isParentsTab
                  ? _buildParentsList(parentsProvider)
                  : _buildSpecialistsList(specialistsProvider),
            ),
          ],
        ),
      ),
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
                  MaterialPageRoute(builder: (_) => const AddParentScreen()),
                );
                if (result == true) context.read<ParentsProvider>().fetchParents();
              } else {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddSpecialistScreen()),
                );
                if (result == true) context.read<SpecialistsProvider>().fetchSpecialists();
              }
            },
            icon: const Icon(Icons.add),
            label: Text(_selectedTab == 0 ? 'Add Parent' : 'Add Specialist'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5B9EF5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
    final bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5B9EF5) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF2D5F9E),
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  Widget _buildParentsList(ParentsProvider provider) {
    if (provider.isLoading) return const Center(child: CircularProgressIndicator());
    if (provider.parents.isEmpty) {
      return const Center(child: Text("No Parents Found", style: TextStyle(color: Color(0xFFA0B4D0))));
    }
    return ListView.separated(
      itemCount: provider.parents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final parent = provider.parents[index];
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
                  parent.name.isNotEmpty ? parent.name[0] : '?',
                  style: const TextStyle(fontSize: 20, color: Color(0xFF2D5F9E), fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parent.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D5F9E))),
                    Text(parent.mobileNumber, style: const TextStyle(color: Color(0xFFA0B4D0), fontSize: 13)),
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
                        parentData: {'id': parent.id, 'name': parent.name, 'mobile_number': parent.mobileNumber},
                      ),
                    ),
                  );
                  if (result == true) context.read<ParentsProvider>().fetchParents();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFDC2626)),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete Parent"),
                      content: const Text("Are you sure you want to delete this parent?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626), foregroundColor: Colors.white),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    final success = await context.read<ParentsProvider>().deleteParent(parent.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success ? "Parent deleted successfully" : "Delete failed"),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecialistsList(SpecialistsProvider provider) {
    if (provider.isLoading) return const Center(child: CircularProgressIndicator());
    if (provider.specialists.isEmpty) {
      return const Center(child: Text("No Specialists Found", style: TextStyle(color: Color(0xFFA0B4D0))));
    }
    return ListView.separated(
      itemCount: provider.specialists.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final SpecialistModel specialist = provider.specialists[index];
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
                  specialist.name.isNotEmpty ? specialist.name[0] : '?',
                  style: const TextStyle(fontSize: 20, color: Color(0xFF2D5F9E), fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(specialist.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D5F9E))),
                    Text(specialist.specialty, style: const TextStyle(color: Color(0xFFA0B4D0), fontSize: 13)),
                  ],
                ),
              ),
              // ✅ التعديل الجديد لزر تعديل الأخصائي
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF5B9EF5)),
                onPressed: () async {
                  // جلب الأخصائي من API أولاً
                  final success = await context
                      .read<SpecialistsProvider>()
                      .fetchSpecialist(specialist.id);
                  if (!context.mounted) return;
                  if (success) {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddSpecialistScreen(
                          specialistModel: context
                              .read<SpecialistsProvider>()
                              .selectedSpecialist,
                        ),
                      ),
                    );
                    if (result == true) {
                      context.read<SpecialistsProvider>().fetchSpecialists();
                    }
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFDC2626)),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete Specialist"),
                      content: const Text("Are you sure you want to delete this specialist?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626), foregroundColor: Colors.white),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    final success = await context.read<SpecialistsProvider>().deleteSpecialist(specialist.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success ? "Specialist deleted successfully" : "Delete failed"),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}