<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BehaviorSeeder extends Seeder
{
    // ترقيم الأنواع الأربعة الثابتة (من BehaviorTypeSeeder):
    // 1 = نوبة غضب | 2 = تفاعل إيجابي | 3 = سلوك تكراري | 4 = استجابة
    public function run(): void
    {
        DB::table('behaviors')->insert([
            // عمر علي (الطفل الأول - Child 1)
            ['date' => '2024-05-01', 'notes' => 'أظهر سلوكاً تكرارياً للاستثارة الذاتية لمدة 10 دقائق خلال الحصة.', 'Behavior_typeid' => 3, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'تواصل بصرياً مع المعلم مرتين اليوم.', 'Behavior_typeid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'استخدم 3 بطاقات من نظام التواصل بتبادل الصور لطلب الطعام بشكل مستقل.', 'Behavior_typeid' => 4, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'أنجز المهمة دون الحاجة لتوجيه أو مساعدة — تقدم رائع!', 'Behavior_typeid' => 4, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-05', 'notes' => 'أصيب بنوبة غضب وانفعال حاد بعد تغيير الروتين المعتاد.', 'Behavior_typeid' => 1, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],

            // لينا علي (الطفل الثاني - Child 2)
            ['date' => '2024-05-01', 'notes' => 'أظهرت سلوكاً عدوانياً تجاه الأقران أثناء النشاط الجماعي.', 'Behavior_typeid' => 1, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'شاركت في اللعب الاجتماعي مع طفل آخر لمدة 5 دقائق.', 'Behavior_typeid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'لوحظ سلوك ترفيف اليدين المتكرر لمدة 20 دقيقة.', 'Behavior_typeid' => 3, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'عبّرت عن حاجتها لفظياً للمرة الأولى.', 'Behavior_typeid' => 4, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],

            // يوسف حسن (الطفل الثالث - Child 3)
            ['date' => '2024-05-01', 'notes' => 'جلسة هادئة، وشارك في النشاط الجماعي.', 'Behavior_typeid' => 2, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'تحسن معدل إنجاز المهام بشكل ملحوظ اليوم.', 'Behavior_typeid' => 4, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'أصيب بنوبة غضب وانفعال حاد بسبب ضوضاء عالية في الممر.', 'Behavior_typeid' => 1, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'انخفضت السلوكيات التكرارية مقارنة بالأسبوع الماضي.', 'Behavior_typeid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}