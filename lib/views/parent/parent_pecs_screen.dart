import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/parent_pecs_provider.dart';
import 'parent_pecs_cards_screen.dart';

class ParentPecsScreen extends StatefulWidget {
  const ParentPecsScreen({super.key});

  @override
  State<ParentPecsScreen> createState() => _ParentPecsScreenState();
}

class _ParentPecsScreenState extends State<ParentPecsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ParentPecsProvider>().fetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParentPecsProvider>();
    final categories = provider.categories;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: const Text('PECS Cards', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : categories.isEmpty
          ? const Center(
        child: Text(
          'لا توجد كاتيغوريز',
          style: TextStyle(color: Color(0xFFA0B4D0), fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ParentPecsCardsScreen(category: category),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD8E8FA)),
                ),
                alignment: Alignment.center,
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5F9E),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}