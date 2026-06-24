import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import 'package:teefi/views/admin/content/add_article_screen.dart';
import 'package:teefi/views/admin/content/add_pecs_screen.dart';
import 'package:teefi/views/admin/content/pecs_category_screen.dart';

class ManageContentScreen extends StatefulWidget {
  final int initialTab; // إضافة متغير استقبال التاب الافتراضي

  const ManageContentScreen({
    super.key,
    this.initialTab = 1, // افتراضياً يفتح على المقالات (1) إذا لم نمرر شيء
  });

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  late int _selectedTab; // تحويلها لـ late لتهيئتها في الـ initState

  final List<Map<String, String>> _articles = [
    {'title': 'How to Handle Autism Tantrums', 'category': 'Behavior'},
    {'title': 'Communication Enhancement Strategies', 'category': 'Communication'},
    {'title': 'Daily Positive Behavior Reinforcement', 'category': 'Daily Care'},
  ];

  final List<Map<String, String>> _pecsCards = [
    {'title': 'Eat', 'category': 'Food'},
    {'title': 'Drink', 'category': 'Food'},
    {'title': 'Sleep', 'category': 'Routine'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab; // تعيين التاب القادم من الـ Dashboard
  }

  @override
  Widget build(BuildContext context) {
    final content = _selectedTab == 1 ? _articles : _pecsCards;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Manage Content',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _tabButton('PECS Cards', 0),
                  _tabButton('Articles', 1),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: content.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = content[index];

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [

                        IconButton(
                          onPressed: () => _showDeleteDialog(content, index),
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                        ),

                        IconButton(
                          onPressed: () {
                            if (_selectedTab == 1) {
                              // Articles → شاشة تعديل المقال
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddArticleScreen(
                                    articleData: item,
                                  ),
                                ),
                              );
                            } else {
                              // PECS → شاشة بطاقات الكاتيغوري
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PecsCategoryScreen(
                                    category: item['category'] ?? 'Food',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.edit, color: AppColors.primary),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item['title']!,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['category']!,
                                style: const TextStyle(color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _selectedTab == 1
                                ? Icons.article_outlined
                                : Icons.style_outlined,
                            color: AppColors.primary,
                          ),
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

      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_selectedTab == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddArticleScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPecsScreen(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: Text(_selectedTab == 1 ? 'Add Article' : 'Add PECS Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Content'),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(List<Map<String, String>> list, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Content'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => list.removeAt(index));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}