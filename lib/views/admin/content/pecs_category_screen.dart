import 'package:flutter/material.dart';

class PecsCategoryScreen extends StatefulWidget {
  final String category;

  const PecsCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<PecsCategoryScreen> createState() => _PecsCategoryScreenState();
}

class _PecsCategoryScreenState extends State<PecsCategoryScreen> {
  final Map<String, List<Map<String, String>>> _allCards = {
    'Food': [
      {'emoji': '🍎', 'title': 'تفاحة'},
      {'emoji': '🍞', 'title': 'خبز'},
      {'emoji': '🥤', 'title': 'مشروب'},
      {'emoji': '🍗', 'title': 'دجاج'},
    ],
    'Play': [
      {'emoji': '🎮', 'title': 'ألعاب'},
      {'emoji': '🧸', 'title': 'دمية'},
      {'emoji': '🎨', 'title': 'رسم'},
    ],
    'Routine': [
      {'emoji': '😴', 'title': 'نوم'},
      {'emoji': '🛁', 'title': 'حمام'},
      {'emoji': '👕', 'title': 'ملابس'},
    ],
    'Emotions': [
      {'emoji': '😊', 'title': 'سعيد'},
      {'emoji': '😢', 'title': 'حزين'},
      {'emoji': '😡', 'title': 'غاضب'},
    ],
    'School': [
      {'emoji': '📚', 'title': 'كتاب'},
      {'emoji': '✏️', 'title': 'قلم'},
      {'emoji': '🏃', 'title': 'نشاط'},
    ],
  };

  late List<Map<String, String>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = List.from(_allCards[widget.category] ?? []);
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _cards.removeAt(index));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),

      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: _cards.isEmpty
          ? const Center(
        child: Text(
          'لا توجد بطاقات',
          style: TextStyle(color: Color(0xFFA0B4D0), fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            final card = _cards[index];
            return GestureDetector(
              onTap: () => _showDeleteDialog(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD8E8FA)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(card['emoji']!, style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text(
                      card['title']!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5F9E),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}