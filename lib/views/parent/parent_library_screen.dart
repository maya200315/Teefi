import 'package:flutter/material.dart';
import 'package:teefi/views/parent/parent_article_detail_screen.dart';

class ParentLibraryScreen extends StatelessWidget {
  const ParentLibraryScreen({super.key});

  final List<Map<String, String>> _articles = const [
    {
      'title': 'كيفية التعامل مع نوبات الغضب',
      'subtitle': 'نصائح عملية لمساعدة طفلك في التحكم بمشاعره',
      'date': 'May 10, 2026',
    },
    {
      'title': 'استراتيجيات تعزيز التواصل',
      'subtitle': 'طرق فعّالة لتحسين مهارات التواصل لدى طفلك',
      'date': 'May 5, 2026',
    },
    {
      'title': 'تعزيز السلوك الإيجابي يومياً',
      'subtitle': 'دليل عملي لتشجيع السلوكيات الإيجابية في الحياة اليومية',
      'date': 'May 1, 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5B9EF5),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () {},
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('• ', style: TextStyle(color: Colors.white54)),
            Text(
              'Guidance Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _articles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final article = _articles[index];
          return _ArticleCard(
            article: article,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ParentArticleDetailScreen(
                  title: article['title']!,
                  subtitle: article['subtitle']!,
                  date: article['date']!,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF5B9EF5),
        unselectedItemColor: const Color(0xFFA0B4D0),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 4) Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.style_outlined), label: 'PECS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes_outlined), label: 'Behavior'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Map<String, String> article;
  final VoidCallback onTap;

  const _ArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B9EF5).withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // العنوان والأيقونة
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF0FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.article_outlined,
                      color: Color(0xFF5B9EF5), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    article['title']!,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5F9E),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // الوصف
            Text(
              article['subtitle']!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFFA0B4D0),
              ),
            ),

            const SizedBox(height: 12),

            // التاريخ والسهم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back,
                    color: Color(0xFF5B9EF5), size: 20),
                Text(
                  article['date']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA0B4D0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}