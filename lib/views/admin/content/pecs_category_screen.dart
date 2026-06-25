import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teefi/views/admin/content/add_pecs_screen.dart';

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
  // 1. تعديل البيانات الافتراضية لتستخدم مسار الصور (Assets) بدلاً من الإيموجي
  final Map<String, List<Map<String, String>>> _allCards = {
    'Food': [
      {'image': 'assets/images/ggoo.png', 'title': 'تفاحة'},
      {'image': 'assets/images/ggoo.png', 'title': 'خبز'},
      {'image': 'assets/images/ggoo.png', 'title': 'مشروب'},
      {'image': 'assets/images/ggoo.png', 'title': 'دجاج'},
    ],
    'Play': [
      {'image': 'assets/images/ggoo.png', 'title': 'ألعاب'},
      {'image': 'assets/images/ggoo.png', 'title': 'دمية'},
      {'image': 'assets/images/ggoo.png', 'title': 'رسم'},
    ],
    'Routine': [
      {'image': 'assets/images/ggoo.png', 'title': 'نوم'},
      {'image': 'assets/images/ggoo.png', 'title': 'حمام'},
      {'image': 'assets/images/ggoo.png', 'title': 'ملابس'},
    ],
    'Emotions': [
      {'image': 'assets/images/ggoo.png', 'title': 'سعيد'},
      {'image': 'assets/images/ggoo.png', 'title': 'حزين'},
      {'image': 'assets/images/ggoo.png', 'title': 'غاضب'},
    ],
    'School': [
      {'image': 'assets/images/ggoo.png', 'title': 'كتاب'},
      {'image': 'assets/images/ggoo.png', 'title': 'قلم'},
      {'image': 'assets/images/ggoo.png', 'title': 'نشاط'},
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
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: const Text('Are you sure you want to delete this card?'),
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
      ),
    );
  }

  void _openAddOrEditCard({Map<String, String>? cardData, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPecsScreen(
          // نمرر الـ cardData في حال التعديل
          pecsData: cardData,
          category: widget.category,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        if (index != null) {
          // تعديل الكارت الحالي بالبيانات المرجعة الجديدة
          _cards[index] = result;
        } else {
          // إضافة كارت جديد للقائمة
          _cards.add(result);
        }
      });
    }
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
            childAspectRatio: 0.8,
          ),
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            final card = _cards[index];
            final imagePath = card['image'] ?? card['imagePath'] ?? '';

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD8E8FA)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // 2. استبدال الـ Text التابع للإيموجي بمكون الـ Image المحدث
                  _buildCardImage(imagePath),

                  const SizedBox(height: 6),
                  Text(
                    card['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5F9E),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // أيقونات التعديل والحذف
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _openAddOrEditCard(
                          cardData: card,
                          index: index,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Color(0xFF5B9EF5),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _showDeleteDialog(index),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // زر إضافة كارد جديد
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () => _openAddOrEditCard(),
            icon: const Icon(Icons.add),
            label: const Text('Add PECS Card'),
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
    );
  }

  // ميثود ذكية لعرض الصورة سواء كانت مخزنة في الأصول (Assets) أو مرفوعة حديثاً من ذاكرة الهاتف (File)
  Widget _buildCardImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    } else if (path.isNotEmpty) {
      return Image.file(
        File(path),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    } else {
      return const Icon(
        Icons.image_not_supported_outlined,
        size: 40,
        color: Color(0xFFA0B4D0),
      );
    }
  }
}