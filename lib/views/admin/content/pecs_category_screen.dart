import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/pecs_provider.dart';
import '../../../models/pecs_category_model.dart';
import 'package:teefi/views/admin/content/add_pecs_screen.dart';

class PecsCategoryScreen extends StatefulWidget {
  final PecsCategoryModel category;

  const PecsCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<PecsCategoryScreen> createState() => _PecsCategoryScreenState();
}

class _PecsCategoryScreenState extends State<PecsCategoryScreen> {

  @override
  void initState() {
    super.initState();
    // جلب الكاتيجوري مع كارداتها من API
    Future.microtask(() =>
        context.read<PecsProvider>().fetchCategory(widget.category.id));
  }

  void _showDeleteDialog(int cardId) {
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
            onPressed: () async {
              Navigator.pop(context);
              await context.read<PecsProvider>().deleteCard(
                cardId: cardId,
                categoryId: widget.category.id,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PecsProvider>();
    final cards = provider.selectedCategory?.pecsCards ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        title: Text(
          widget.category.name,
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
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddPecsScreen(
                                cardModel: card,
                                categoryId: widget.category.id,
                              ),
                            ),
                          );
                          if (context.mounted) {
                            context.read<PecsProvider>().fetchCategory(widget.category.id);
                          }
                        },
                        child: const Icon(Icons.edit, size: 18, color: Color(0xFF5B9EF5)),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _showDeleteDialog(card.id),
                        child: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPecsScreen(
                    categoryId: widget.category.id,
                  ),
                ),
              );
              if (context.mounted) {
                context.read<PecsProvider>().fetchCategory(widget.category.id);
              }
            },
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

  Widget _buildCardImage(String imageUrl) {
    print('IMAGE URL: $imageUrl');
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