import 'package:flutter/material.dart';

class ParentArticleDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;

  const ParentArticleDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Guidance Library',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 13, color: Color(0xFFA0B4D0)),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5F9E),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFD8E8FA)),
            const SizedBox(height: 20),
            // ✅ المحتوى الحقيقي من الـ API
            Text(
              subtitle,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF2D5F9E),
                height: 1.9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}