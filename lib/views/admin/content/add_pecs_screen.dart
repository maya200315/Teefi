import 'package:flutter/material.dart';

class AddPecsScreen extends StatefulWidget {
  final Map<String, String>? pecsData;
  final String? category;

  const AddPecsScreen({
    super.key,
    this.pecsData,
    this.category,
  });

  @override
  State<AddPecsScreen> createState() => _AddPecsScreenState();
}

class _AddPecsScreenState extends State<AddPecsScreen> {
  final TextEditingController _titleController = TextEditingController();

  late String _selectedCategory;

  String _imagePath = 'assets/images/ggoo.png';

  final List<String> _categories = [
    'Food',
    'Play',
    'Routine',
    'Emotions',
    'School',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.pecsData != null) {
      _titleController.text = widget.pecsData!['title'] ?? '';
      _selectedCategory =
          widget.pecsData!['category'] ?? widget.category ?? 'Food';

      _imagePath = widget.pecsData!['image'] ?? 'assets/images/ggoo.png';
    } else {
      _selectedCategory = widget.category ?? 'Food';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a card name')),
      );
      return;
    }

    Navigator.pop(context, {
      'title': _titleController.text.trim(),
      'category': _selectedCategory,
      'image': _imagePath,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.pecsData != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit PECS Card' : 'Add PECS Card',
          style: const TextStyle(fontWeight: FontWeight.bold),
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

            // IMAGE (تم الاستبدال والتعديل هنا بناءً على طلبك)
            Center(
              child: Column(
                children: [
                  if (isEdit)
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD8E8FA),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          _imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD8E8FA),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 50,
                          color: Color(0xFF5B9EF5),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  if (isEdit)
                    TextButton(
                      onPressed: () {
                        // image picker لاحقاً
                      },
                      child: const Text(
                        'Change Image',
                        style: TextStyle(
                          color: Color(0xFF5B9EF5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () {
                        // image picker لاحقاً
                      },
                      child: const Text(
                        'Add Image',
                        style: TextStyle(
                          color: Color(0xFF5B9EF5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TITLE
            const Text(
              'اسم البطاقة',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D5F9E),
              ),
            ),

            const SizedBox(height: 6),

            TextField(
              controller: _titleController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'مثال: طعام',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // CATEGORY
            const Text(
              'التصنيف',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D5F9E),
              ),
            ),

            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _categories
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B9EF5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isEdit ? 'تحديث' : 'حفظ',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}