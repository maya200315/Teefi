// lib/views/superadmin/superadmin_pecs_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuperAdminPecsProvider>().fetchAllPecsCards();
    });
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
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : provider.cards.isEmpty
          ? const Center(child: Text('لا توجد بطاقات حالياً'))
          : RefreshIndicator(
        onRefresh: () => provider.fetchAllPecsCards(),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: card.imageUrl.isNotEmpty
                  ? Image.network(
                card.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primaryLight,
                  child: const Icon(Icons.broken_image_outlined, color: AppColors.primary),
                ),
              )
                  : Container(
                color: AppColors.primaryLight,
                child: const Icon(Icons.image_outlined, color: AppColors.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              card.title,
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}