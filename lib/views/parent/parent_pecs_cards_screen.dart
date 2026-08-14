import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/parent_pecs_provider.dart';
import '../../models/pecs_category_model.dart';

class ParentPecsCardsScreen extends StatefulWidget {
  final PecsCategoryModel category;

  const ParentPecsCardsScreen({super.key, required this.category});

  @override
  State<ParentPecsCardsScreen> createState() => _ParentPecsCardsScreenState();
}

class _ParentPecsCardsScreenState extends State<ParentPecsCardsScreen> {
  bool _imagesReady = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _imagesReady = false);

    await context.read<ParentPecsProvider>().fetchCategoryCards(widget.category.id);

    if (!mounted) return;

    final cards = context.read<ParentPecsProvider>().cards;
    final urls = cards
        .map((c) => c.imageUrl)
        .where((url) => url.startsWith('http'));

    await Future.wait(
      urls.map((url) => precacheImage(CachedNetworkImageProvider(url), context)),
    );

    if (!mounted) return;
    setState(() => _imagesReady = true);
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
      body: (provider.isLoading || !_imagesReady)
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
            crossAxisCount: 2, // 👈 تم التغيير لـ 2 أعمدة لإعطاء مساحة أكبر للبطاقات
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5B9EF5).withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: const Color(0xFFD8E8FA)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: _buildCardImage(card.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15, // 👈 خط أكبر وأوضح
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
    // 👈 حجم أضخم للصور (110x110) لملء البطاقة بشكل جميل
    if (imageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
          fadeInDuration: Duration.zero,
          errorWidget: (context, url, error) => const Icon(
            Icons.image_not_supported_outlined,
            size: 60,
            color: Color(0xFFA0B4D0),
          ),
        ),
      );
    } else if (imageUrl.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(imageUrl, width: 110, height: 110, fit: BoxFit.cover),
      );
    } else if (imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.file(File(imageUrl), width: 110, height: 110, fit: BoxFit.cover),
      );
    } else {
      return const Icon(Icons.image_not_supported_outlined, size: 60, color: Color(0xFFA0B4D0));
    }
  }
}