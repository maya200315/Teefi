import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../providers/pecs_provider.dart';
import '../../../models/pecs_category_model.dart';

class AddPecsScreen extends StatefulWidget {
  final PecsCardModel? cardModel; // للتعديل
  final int categoryId;           // مطلوب دائماً

  const AddPecsScreen({
    super.key,
    this.cardModel,
    required this.categoryId,
  });

  @override
  State<AddPecsScreen> createState() => _AddPecsScreenState();
}

class _AddPecsScreenState extends State<AddPecsScreen> {
  final TextEditingController _titleController = TextEditingController();
  String? _localImagePath; // المسار المحلي للصورة المختارة

  @override
  void initState() {
    super.initState();
    if (widget.cardModel != null) {
      _titleController.text = widget.cardModel!.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _localImagePath = picked.path);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a card name')),
      );
      return;
    }

    final provider = context.read<PecsProvider>();
    bool success;

    if (widget.cardModel == null) {
      // إضافة — الصورة مطلوبة
      if (_localImagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }
      success = await provider.createCard(
        title: _titleController.text.trim(),
        categoryId: widget.categoryId,
        imagePath: _localImagePath!,
      );
    } else {
      // تعديل — الصورة اختيارية
      success = await provider.updateCard(
        id: widget.cardModel!.id,
        title: _titleController.text.trim(),
        categoryId: widget.categoryId,
        imagePath: _localImagePath, // null إذا ما غيّرت
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
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.cardModel != null;

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

            // الصورة
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFD8E8FA), width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: _localImagePath != null
                            ? Image.file(File(_localImagePath!), fit: BoxFit.cover)
                            : isEdit && widget.cardModel!.imageUrl.isNotEmpty
                            ? Image.network(widget.cardModel!.imageUrl, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40, color: Color(0xFFA0B4D0),
                            ))
                            : const Center(
                          child: Icon(Icons.add, size: 50, color: Color(0xFF5B9EF5)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _pickImage,
                    child: Text(
                      isEdit ? 'Change Image' : 'Add Image',
                      style: const TextStyle(
                        color: Color(0xFF5B9EF5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // اسم البطاقة
            const Text('اسم البطاقة',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F9E),
                )),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'مثال: طعام',
                hintTextDirection: TextDirection.rtl,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _save,
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