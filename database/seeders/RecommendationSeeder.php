<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RecommendationSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('recommendations')->insert([
            // Dr. Sara recommendations for Omar
            [
                'text'       => 'حافظ على جدول يومي ثابت باستخدام جداول بصرية لتقليل القلق والانفعالات المرتبطة بالتغييرات.',
                'date'       => '2024-05-05',
                'Userid'     => 2,
                'Childid'    => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'زد جلسات تدريب PECS إلى مرتين يوميًا. ركز على طلب الطعام والتعبير عن المشاعر.',
                'date'       => '2024-05-06',
                'Userid'     => 2,
                'Childid'    => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Dr. Sara recommendations for Lina
            [
                'text'       => 'قدمي أدوات مريحة للحواس مثل ألعاب الفidget لمساعدة لينا على تنظيم نفسها خلال الأنشطة الجماعية',
                'date'       => '2024-05-05',
                'Userid'     => 2,
                'Childid'    => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'تنفيذ برنامج قصص اجتماعية لمساعدة لينا على فهم التفاعل المناسب مع الأقران وتقليل العدوانية.',
                'date'       => '2024-05-06',
                'Userid'     => 2,
                'Childid'    => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Dr. Khaled recommendations for Youssef
            [
                'text'       => 'توفير سماعات رأس عازلة للضوضاء لاستخدامها في الصف لتقليل التحفيز الحسي من الأصوات البيئية.',
                'date'       => '2024-05-05',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'الاستمرار في تعزيز سلوك إتمام المهام باستخدام نظام مكافآت رمزية. يوسف يستجيب جيدًا للتعزيز الإيجابي.',
                'date'       => '2024-05-06',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'جدولة اجتماعات تقدم شهرية مع الآباء لمواءمة استراتيجيات المنزل والعلاج لتحقيق نتائج سلوكية متسقة.',
                'date'       => '2024-05-07',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
