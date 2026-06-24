<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WeeklyReportSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('weekly_reports')->insert([
            // Omar Ali — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 10,
                'positive_count'  => 6,
                'negative_count'  => 4,
                'summary'         => 'أظهر عمر تحسناً ملحوظاً في التواصل هذا الأسبوع. زاد استخدام بطاقات PECS. حدث انهيار عصبي مرة واحدة بسبب تغيير غير متوقع في الروتين.',
                'Childid'         => 1,
                'Userid'          => 2,
                'created_at'      => now(),
                'updated_at'      => now(),
            ],
            // Lina Ali — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 8,
                'positive_count'  => 4,
                'negative_count'  => 4,
                'summary'         => 'أظهرت لينا تحسنًا في الاتصال البصري خلال الوقت الفردي. لكنها تواجه صعوبة في التحكم في سلوكها الاجتماعي.',
                'Childid'         => 2,
                'Userid'          => 2,
                'created_at'      => now(),
                'updated_at'      => now(),
            ],
            // Youssef Hassan — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 12,
                'positive_count'  => 8,
                'negative_count'  => 4,
                'summary'         => 'أظهر يوسف تحسناً ملحوظاً في إتمام المهام هذا الأسبوع. حدث انهيار عصبي بسبب الضوضاء البيئية. يُنصح بتوفير تجهيزات حسية للصف.',
                'Childid'         => 3,
                'Userid'          => 3,
                'created_at'      => now(),
                'updated_at'      => now(),
            ],
            // Omar Ali — Week 2
            [
                'week_start'      => '2024-05-06',
                'week_end'        => '2024-05-12',
                'total_behaviors' => 9,
                'positive_count'  => 7,
                'negative_count'  => 2,
                'summary'         => 'أظهر عمر تحسناً ملحوظاً في التواصل هذا الأسبوع. زاد استخدام بطاقات PECS. حدث انهيار عصبي مرة واحدة بسبب تغيير غير متوقع في الروتين.',
                'Childid'         => 1,
                'Userid'          => 2,
                'created_at'      => now(),
                'updated_at'      => now(),
            ],
        ]);
    }
}
