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
        $rows = [];

        // عمر علي (Child 1) — أسبوع حالي غالباً إيجابي/استجابة
        $omar = [
            ['days_ago' => 0, 'type' => 3, 'notes' => 'أظهر سلوكاً تكرارياً للاستثارة الذاتية لمدة 10 دقائق خلال الحصة.'],
            ['days_ago' => 1, 'type' => 2, 'notes' => 'تواصل بصرياً مع المعلم مرتين اليوم.'],
            ['days_ago' => 2, 'type' => 4, 'notes' => 'استخدم 3 بطاقات من نظام التواصل بتبادل الصور لطلب الطعام بشكل مستقل.'],
            ['days_ago' => 3, 'type' => 4, 'notes' => 'أنجز المهمة دون الحاجة لتوجيه أو مساعدة — تقدم رائع!'],
            ['days_ago' => 4, 'type' => 1, 'notes' => 'أصيب بنوبة غضب وانفعال حاد بعد تغيير الروتين المعتاد.'],
            ['days_ago' => 10, 'type' => 2, 'notes' => 'شارك بنشاط جماعي دون مقاومة.'],
            ['days_ago' => 18, 'type' => 4, 'notes' => 'استجاب بسرعة لتعليمات المعلمة.'],
        ];

        // لينا علي (Child 2) — نسبة نوبات غضب وتكرار أعلى
        $lina = [
            ['days_ago' => 0, 'type' => 1, 'notes' => 'أظهرت سلوكاً عدوانياً تجاه الأقران أثناء النشاط الجماعي.'],
            ['days_ago' => 1, 'type' => 2, 'notes' => 'شاركت في اللعب الاجتماعي مع طفل آخر لمدة 5 دقائق.'],
            ['days_ago' => 2, 'type' => 3, 'notes' => 'لوحظ سلوك ترفيف اليدين المتكرر لمدة 20 دقيقة.'],
            ['days_ago' => 3, 'type' => 4, 'notes' => 'عبّرت عن حاجتها لفظياً للمرة الأولى.'],
            ['days_ago' => 5, 'type' => 1, 'notes' => 'نوبة غضب بسبب رفض تغيير النشاط.'],
            ['days_ago' => 12, 'type' => 3, 'notes' => 'سلوك تكراري ملحوظ خلال وقت الانتظار.'],
            ['days_ago' => 20, 'type' => 1, 'notes' => 'انفعال حاد عند دخول شخص غريب للصف.'],
        ];

        // يوسف حسن (Child 3) — تحسن تدريجي عبر الوقت
        $youssef = [
            ['days_ago' => 0, 'type' => 2, 'notes' => 'جلسة هادئة، وشارك في النشاط الجماعي.'],
            ['days_ago' => 1, 'type' => 4, 'notes' => 'تحسن معدل إنجاز المهام بشكل ملحوظ اليوم.'],
            ['days_ago' => 2, 'type' => 1, 'notes' => 'أصيب بنوبة غضب وانفعال حاد بسبب ضوضاء عالية في الممر.'],
            ['days_ago' => 3, 'type' => 3, 'notes' => 'انخفضت السلوكيات التكرارية مقارنة بالأسبوع الماضي.'],
            ['days_ago' => 6, 'type' => 2, 'notes' => 'تفاعل إيجابي مع زميل جديد بالصف.'],
            ['days_ago' => 15, 'type' => 1, 'notes' => 'نوبة غضب أثناء الانتقال بين الحصص.'],
            ['days_ago' => 25, 'type' => 4, 'notes' => 'استجابة جيدة لتعليمات جديدة.'],
        ];

        foreach ([1 => $omar, 2 => $lina, 3 => $youssef] as $childId => $entries) {
            foreach ($entries as $entry) {
                $rows[] = [
                    'date'            => now()->subDays($entry['days_ago'])->toDateString(),
                    'notes'           => $entry['notes'],
                    'Behavior_typeid' => $entry['type'],
                    'Childid'         => $childId,
                    'created_at'      => now(),
                    'updated_at'      => now(),
                ];
            }
        }

        DB::table('behaviors')->insert($rows);
    }
}