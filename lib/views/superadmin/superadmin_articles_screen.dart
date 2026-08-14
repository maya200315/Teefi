// lib/views/superadmin/superadmin_articles_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/superadmin_articles_provider.dart';
import '../../models/superadmin_article_model.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

class SuperAdminArticlesScreen extends StatefulWidget {
  const SuperAdminArticlesScreen({super.key});

  @override
  State<SuperAdminArticlesScreen> createState() => _SuperAdminArticlesScreenState();
}

class _SuperAdminArticlesScreenState extends State<SuperAdminArticlesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuperAdminArticlesProvider>().fetchAllArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SuperAdminArticlesProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('المكتبة الإرشادية', style: TextStyle(color: Colors.white)),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : provider.articles.isEmpty
          ? const Center(child: Text('لا توجد مقالات حالياً'))
          : RefreshIndicator(
        onRefresh: () => provider.fetchAllArticles(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.articles.length,
          itemBuilder: (context, index) {
            final article = provider.articles[index];
            return _buildArticleCard(article);
          },
        ),
      ),
    );
  }

  Widget _buildArticleCard(SuperAdminArticleModel article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: AppTextStyles.heading2,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            article.content,
            style: AppTextStyles.bodyLarge,
            textDirection: TextDirection.rtl,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          // 👈 تم حذف اسم الدكتور والإبقاء على التاريخ فقط
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              article.datetime.split('T').first,
              style: AppTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}