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

  @override
  void initState() {
    super.initState();
    if (widget.articleModel != null) {
      _titleController.text = widget.articleModel!.title;
      _contentController.text = widget.articleModel!.content;
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
              decoration: InputDecoration(
                hintText: 'Enter article title...',
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
              decoration: InputDecoration(
                hintText: 'Write article content here...',
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
                    success = await provider.createArticle(
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
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