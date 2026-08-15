// lib/views/superadmin/superadmin_pecs_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/superadmin_pecs_provider.dart';
import '../../models/superadmin_pecs_card_model.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class SuperAdminPecsScreen extends StatefulWidget {
  const SuperAdminPecsScreen({super.key});

  @override
  State<SuperAdminPecsScreen> createState() => _SuperAdminPecsScreenState();
}

class _SuperAdminPecsScreenState extends State<SuperAdminPecsScreen> {
  bool _imagesReady = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _imagesReady = false);

    await context.read<SuperAdminPecsProvider>().fetchAllPecsCards();

    if (!mounted) return;

    final cards = context.read<SuperAdminPecsProvider>().cards;
    final urls = cards.map((c) => c.imageUrl).where((url) => url.isNotEmpty);

    await Future.wait(
      urls.map((url) => precacheImage(CachedNetworkImageProvider(url), context)),
    );

    if (!mounted) return;
    setState(() => _imagesReady = true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SuperAdminPecsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('بطاقات PECS', style: TextStyle(color: Colors.white)),
      ),
      body: (provider.isLoading || !_imagesReady)
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : provider.cards.isEmpty
          ? const Center(child: Text('لا توجد بطاقات حالياً'))
          : RefreshIndicator(
        onRefresh: () => _loadData(),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: provider.cards.length,
          itemBuilder: (context, index) {
            final card = provider.cards[index];
            return _buildPecsCard(card);
          },
        ),
      ),
    );
  }

  Widget _buildPecsCard(SuperAdminPecsCardModel card) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: card.imageUrl.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: card.imageUrl,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration.zero,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image_outlined,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : const Icon(Icons.image_outlined, size: 60, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            card.title,
            style: AppTextStyles.bodyLarge.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}