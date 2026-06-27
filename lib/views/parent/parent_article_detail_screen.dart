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
            // التاريخ
            Text(
              date,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFFA0B4D0),
              ),
            ),

            const SizedBox(height: 16),

            // العنوان
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

            const SizedBox(height: 12),

            // الوصف المختصر
            Text(
              subtitle,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFA0B4D0),
                height: 1.6,
              ),
            ),

            const SizedBox(height: 20),

            const Divider(color: Color(0xFFD8E8FA)),

            const SizedBox(height: 20),

            // المحتوى
            const Text(
              'يعاني كثير من أطفال التوحد من صعوبة في التعبير عن مشاعرهم، مما قد يؤدي إلى نوبات غضب مفاجئة. هذه النوبات ليست تصرفاً مقصوداً، بل هي استجابة طبيعية لإحباط أو إرهاق حسي أو عدم قدرة على التواصل.\n\nما الذي يمكنك فعله؟\n\n١. حافظ على هدوئك\nطفلك يستشعر مشاعرك. كلما بقيت هادئاً، كلما ساعدته على التهدئة بشكل أسرع.\n\n٢. تعرّف على المحفزات\nلاحظ المواقف التي تسبق النوبة — هل هو جائع؟ متعب؟ في بيئة صاخبة؟ تسجيل هذه الملاحظات يساعدك على تفادي المحفزات.\n\n٣. أنشئ مساحة آمنة\nخصص زاوية هادئة في المنزل يلجأ إليها طفلك عندما يشعر بالإرهاق.\n\n٤. استخدم بطاقات PECS\nالبطاقات المصورة تساعد طفلك على التعبير عما يريد أو يشعر به قبل أن يصل إلى مرحلة الانفجار.\n\n٥. كافئ السلوك الإيجابي\nعندما يتعامل طفلك مع موقف صعب بشكل جيد، أشكره وكافئه فوراً لتعزيز هذا السلوك.',
              textAlign: TextAlign.right,
              style: TextStyle(
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