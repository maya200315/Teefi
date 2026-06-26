import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/content_provider.dart';
import '../../../models/article_model.dart';

class AddArticleScreen extends StatefulWidget {
  final ArticleModel? articleModel;

  const AddArticleScreen({super.key, this.articleModel});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // ✅ المتغير المضاف للتاريخ
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.articleModel != null) {
      _titleController.text = widget.articleModel!.title;
      _contentController.text = widget.articleModel!.content;
      try {
        _selectedDate = DateTime.parse(widget.articleModel!.datetime);
      } catch (e) {
        _selectedDate = DateTime.now();
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String? _validate() {
    if (_titleController.text.trim().isEmpty) return 'Please enter article title';
    if (_contentController.text.trim().isEmpty) return 'Please enter article content';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),

      appBar: AppBar(
        title: Text(
          widget.articleModel == null ? 'Add Article' : 'Edit Article',
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
            const Text('Article Title',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F9E),
                )),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.multiline, // ✅ تم إضافة هاد
              textInputAction: TextInputAction.next,  // ✅ تم إضافة هاد
              decoration: InputDecoration(
                hintText: 'أدخل عنوان المقال...',
                hintTextDirection: TextDirection.rtl,
                hintStyle: const TextStyle(color: Color(0xFFA0B4D0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
              ),
            ),

            // ✅ الـ Date Picker widget المضاف بعد الـ title field
            const SizedBox(height: 16),
            const Text('Date',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F9E),
                )),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E8FA)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF5B9EF5)),
                    Text(
                      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2,'0')}-${_selectedDate.day.toString().padLeft(2,'0')}',
                      style: const TextStyle(color: Color(0xFF2D5F9E)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text('Content',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F9E),
                )),
            const SizedBox(height: 6),
            TextField(
              controller: _contentController,
              maxLines: 10,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.multiline, // ✅ تم إضافة هاد
              textInputAction: TextInputAction.newline, // ✅ تم إضافة هاد
              decoration: InputDecoration(
                hintText: 'اكتبي محتوى المقال هنا...',
                hintTextDirection: TextDirection.rtl,
                hintStyle: const TextStyle(color: Color(0xFFA0B4D0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final error = _validate();
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error), backgroundColor: Colors.red),
                    );
                    return;
                  }

                  final provider = context.read<ContentProvider>();
                  bool success;

                  if (widget.articleModel == null) {
                    // ✅ الاستدعاء الصحيح مع تمرير الـ datetime المُعدل
                    success = await provider.createArticle(
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      datetime: '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2,'0')}-${_selectedDate.day.toString().padLeft(2,'0')} 00:00:00',
                    );
                  } else {
                    success = await provider.updateArticle(
                      id: widget.articleModel!.id,
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                    );
                  }

                  if (context.mounted) {
                    if (success) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(provider.errorMessage ?? 'Operation failed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B9EF5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  widget.articleModel == null ? 'Save Article' : 'Update Article',
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