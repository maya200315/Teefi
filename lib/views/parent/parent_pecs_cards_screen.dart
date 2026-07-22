import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/parent_pecs_provider.dart';
import '../../models/pecs_category_model.dart';

class ParentPecsCardsScreen extends StatefulWidget {
  final PecsCategoryModel category;

  const ParentPecsCardsScreen({super.key, required this.category});

  @override
  State<ParentPecsCardsScreen> createState() => _ParentPecsCardsScreenState();
}

class _ParentPecsCardsScreenState extends State<ParentPecsCardsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ParentPecsProvider>().fetchCategoryCards(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParentPecsProvider>();
    final cards = provider.cards;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: Text(
          provider.selectedCategory?.name ?? widget.category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cards.isEmpty
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
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD8E8FA)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCardImage(card.imageUrl),
                  const SizedBox(height: 6),
                  Text(
                    card.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5F9E),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.image_not_supported_outlined,
          size: 40,
          color: Color(0xFFA0B4D0),
        ),
      );
    } else if (imageUrl.startsWith('assets/')) {
      return Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover);
    } else if (imageUrl.isNotEmpty) {
      return Image.file(File(imageUrl), width: 60, height: 60, fit: BoxFit.cover);
    } else {
      return const Icon(Icons.image_not_supported_outlined, size: 40, color: Color(0xFFA0B4D0));
    }
  }
}