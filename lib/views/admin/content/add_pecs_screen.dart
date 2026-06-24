import 'package:flutter/material.dart';

class AddPecsScreen extends StatefulWidget {
  final Map<String, String>? pecsData;

  const AddPecsScreen({
    super.key,
    this.pecsData,
  });

  @override
  State<AddPecsScreen> createState() => _AddPecsScreenState();
}

class _AddPecsScreenState extends State<AddPecsScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedEmoji = '🍎';
  String _selectedCategory = 'Food';

  final List<String> _emojis = [
    '🍎', '🥤', '🛁', '🎮', '😴', '🚗',
    '📚', '🎨', '🏃', '🍞', '🧸', '👕',
  ];

  final List<String> _categories = [
    'Food', 'Play', 'Routine', 'Emotions', 'School',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.pecsData != null) {
      _titleController.text = widget.pecsData!['title'] ?? '';
      _selectedEmoji = widget.pecsData!['emoji'] ?? '🍎';
      _selectedCategory = widget.pecsData!['category'] ?? 'Food';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),

      appBar: AppBar(
        title: Text(
          widget.pecsData == null ? 'Add PECS Card' : 'Edit PECS Card',
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

            // Preview
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF0FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD8E8FA)),
                ),
                child: Center(
                  child: Text(_selectedEmoji, style: const TextStyle(fontSize: 60)),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Emoji Picker
            const Text(
              'اختر رمز',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D5F9E)),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD8E8FA)),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _emojis.length,
                itemBuilder: (context, index) {
                  final emoji = _emojis[index];
                  final isSelected = emoji == _selectedEmoji;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedEmoji = emoji),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF5B9EF5) : const Color(0xFFF2F7FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(emoji, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Title
            const Text(
              'اسم البطاقة',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D5F9E)),
            ),

            const SizedBox(height: 6),

            TextField(
              controller: _titleController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'مثال: طعام',
                hintStyle: const TextStyle(color: Color(0xFFA0B4D0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
              ),
            ),

            const SizedBox(height: 16),

            // Category
            const Text(
              'التصنيف',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D5F9E)),
            ),

            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
              ),
              items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B9EF5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  widget.pecsData == null ? 'حفظ' : 'تحديث',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}