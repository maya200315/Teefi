<?php

// namespace Database\Seeders;

// use Illuminate\Database\Seeder;
// use Illuminate\Support\Facades\DB;

// class WeeklyReportSeeder extends Seeder
// {
//     public function run(): void
//     {
//         DB::table('weekly_reports')->insert([
//             // Omar Ali — Week 1
//             [
//                 'week_start'      => '2024-04-29',
//                 'week_end'        => '2024-05-05',
//                 'total_behaviors' => 10,
//                 'positive_count'  => 6,
//                 'negative_count'  => 4,
//                 'summary'         => 'أظهر عمر تحسناً ملحوظاً في التواصل هذا الأسبوع. زاد استخدام بطاقات PECS. حدث انهيار عصبي مرة واحدة بسبب تغيير غير متوقع في الروتين.',
//                 'Childid'         => 1,
//                 'Userid'          => 2,
//                 'created_at'      => now(),
//                 'updated_at'      => now(),
//             ],
//             // Lina Ali — Week 1
//             [
//                 'week_start'      => '2024-04-29',
//                 'week_end'        => '2024-05-05',
//                 'total_behaviors' => 8,
//                 'positive_count'  => 4,
//                 'negative_count'  => 4,
//                 'summary'         => 'أظهرت لينا تحسنًا في الاتصال البصري خلال الوقت الفردي. لكنها تواجه صعوبة في التحكم في سلوكها الاجتماعي.',
//                 'Childid'         => 2,
//                 'Userid'          => 2,
//                 'created_at'      => now(),
//                 'updated_at'      => now(),
//             ],
//             // Youssef Hassan — Week 1
//             [
//                 'week_start'      => '2024-04-29',
//                 'week_end'        => '2024-05-05',
//                 'total_behaviors' => 12,
//                 'positive_count'  => 8,
//                 'negative_count'  => 4,
//                 'summary'         => 'أظهر يوسف تحسناً ملحوظاً في إتمام المهام هذا الأسبوع. حدث انهيار عصبي بسبب الضوضاء البيئية. يُنصح بتوفير تجهيزات حسية للصف.',
//                 'Childid'         => 3,
//                 'Userid'          => 3,
//                 'created_at'      => now(),
//                 'updated_at'      => now(),
//             ],
//             // Omar Ali — Week 2
//             [
//                 'week_start'      => '2024-05-06',
//                 'week_end'        => '2024-05-12',
//                 'total_behaviors' => 9,
//                 'positive_count'  => 7,
//                 'negative_count'  => 2,
//                 'summary'         => 'أظهر عمر تحسناً ملحوظاً في التواصل هذا الأسبوع. زاد استخدام بطاقات PECS. حدث انهيار عصبي مرة واحدة بسبب تغيير غير متوقع في الروتين.',
//                 'Childid'         => 1,
//                 'Userid'          => 2,
//                 'created_at'      => now(),
//                 'updated_at'      => now(),
//             ],
//         ]);
//     }
// }

namespace Database\Seeders;

use App\Services\BehaviorSummaryService;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WeeklyReportSeeder extends Seeder
{
    public function run(): void
    {
        $summaryService = new BehaviorSummaryService();

        // بدل ما نكتب الملخص يدوياً، منحط بس الأعداد (زي ما رح يجيبها
        // BehaviorStatsService من جدول Behavior فعلياً)، ومنولّد الملخص
        // تلقائياً بنفس المنطق يلي رح يشتغل بالنظام الحقيقي.
        // ملاحظة: هاد الداتا الأصلية ما فيها فصل بين "تفاعل إيجابي" و"استجابة"
        // ولا سلوك تكراري، فمنعتبر positive_count = (positive + response)
        // و repetitive = 0 لأغراض السيدر فقط.
        $rows = [
            // Omar Ali — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 10,
                'positive_count'  => 6,
                'negative_count'  => 4,
                'Childid'         => 1,
                'Userid'          => 2,
            ],
            // Lina Ali — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 8,
                'positive_count'  => 4,
                'negative_count'  => 4,
                'Childid'         => 2,
                'Userid'          => 2,
            ],
            // Youssef Hassan — Week 1
            [
                'week_start'      => '2024-04-29',
                'week_end'        => '2024-05-05',
                'total_behaviors' => 12,
                'positive_count'  => 8,
                'negative_count'  => 4,
                'Childid'         => 3,
                'Userid'          => 3,
            ],
            // Omar Ali — Week 2
            [
                'week_start'      => '2024-05-06',
                'week_end'        => '2024-05-12',
                'total_behaviors' => 9,
                'positive_count'  => 7,
                'negative_count'  => 2,
                'Childid'         => 1,
                'Userid'          => 2,
            ],
        ];

        $now = now();

        DB::table('weekly_reports')->insert(array_map(function (array $row) use ($summaryService, $now) {
            $total = $row['total_behaviors'];

            $percentages = [
                'anger'      => $total ? $row['negative_count'] / $total * 100 : 0,
                'positive'   => $total ? $row['positive_count'] / $total * 100 : 0,
                'repetitive' => 0,
                'response'   => 0,
            ];

            $row['summary']    = $summaryService->generate([
                'total'       => $total,
                'percentages' => $percentages,
            ]);
            $row['created_at'] = $now;
            $row['updated_at'] = $now;

            return $row;
        }, $rows));
    }
}
