import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../providers/content_provider.dart';
import '../../../models/article_model.dart';
import 'package:teefi/views/admin/content/add_article_screen.dart';
import 'package:teefi/views/admin/content/add_pecs_screen.dart';
import 'package:teefi/views/admin/content/pecs_category_screen.dart';

class ManageContentScreen extends StatefulWidget {
  final int initialTab;

  const ManageContentScreen({super.key, this.initialTab = 1});

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    // جلب المقالات من الـ API عند فتح الشاشة
    Future.microtask(() =>
        context.read<ContentProvider>().fetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContentProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Manage Content',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _tabButton('Category PECS', 0),
                  _tabButton('Articles', 1),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _selectedTab == 1
                  ? _buildArticlesList(provider)
                  : _buildCategoriesList(provider),
            ),
          ],
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_selectedTab == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddArticleScreen()));
              } else {
                _showAddCategoryDialog(context);
              }
            },
            icon: const Icon(Icons.add),
            label: Text(_selectedTab == 1 ? 'Add Article' : 'Add Category'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Content'),
        ],
      ),
    );
  }

  Widget _buildArticlesList(ContentProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.articles.isEmpty) {
      return const Center(
        child: Text("No Articles Found",
            style: TextStyle(color: AppColors.textGrey)),
      );
    }

    return ListView.separated(
      itemCount: provider.articles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ArticleModel article = provider.articles[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => _showDeleteDialog(
                  context: context,
                  onConfirm: () =>
                      context.read<ContentProvider>().deleteArticle(article.id),
                ),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddArticleScreen(articleModel: article),
                  ),
                ),
                icon: const Icon(Icons.edit, color: AppColors.primary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(article.title,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        )),
                    const SizedBox(height: 4),
                    Text(article.datetime,
                        style: const TextStyle(color: AppColors.textGrey)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.article_outlined, color: AppColors.primary),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoriesList(ContentProvider provider) {
    return ListView.separated(
      itemCount: provider.pecsCategories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final category = provider.pecsCategories[index];
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => PecsCategoryScreen(category: category))),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _showDeleteDialog(
                    context: context,
                    onConfirm: () =>
                        context.read<ContentProvider>().deleteCategory(index),
                  ),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
                IconButton(
                  onPressed: () => _showEditCategoryDialog(context, index),
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                ),
                Expanded(
                  child: Text(category,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      )),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.style_outlined, color: AppColors.primary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Category'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Category name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<ContentProvider>().addCategory(controller.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(BuildContext context, int index) {
    final controller = TextEditingController(
        text: context.read<ContentProvider>().pecsCategories[index]);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Category'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<ContentProvider>().updateCategory(index, controller.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textDark,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}