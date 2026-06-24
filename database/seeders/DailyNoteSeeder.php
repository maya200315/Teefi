<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DailyNoteSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('daily_notes')->insert([
            // Dr. Sara notes on Omar
            ['note' => 'كان عمر هادئًا اليوم واستجاب جيدًا للإشارات البصرية. استمر في تعزيز', 'date' => '2024-05-01', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'واجه عمر صعوبة في الانتقال بين الأنشطة. استخدم المؤقت للمساعدة في الانتقالات.', 'date' => '2024-05-02', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'جلسة رائعة اليوم! بدأ عمر التواصل مرتين باستخدام بطاقات PECS دون الحاجة للتوجيه.',   'date' => '2024-05-03', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],

            // Dr. Sara notes on Lina
            ['note' => 'أظهرت لينا تحسنًا في الاتصال البصري خلال الوقت الفردي.',                               'date' => '2024-05-01', 'Userid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'أصيبت لينا بالغضب أثناء وقت الغداء. قد يكون لديها حساسية حسية للمساحات.',               'date' => '2024-05-02', 'Userid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],

            // Dr. Khaled notes on Youssef
            ['note' => 'شارك يوسف جيدًا في مجموعة مهارات التواصل الاجتماعي اليوم.',                                       'date' => '2024-05-01', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'واجه يوسف صعوبة مع البيئة المزدحمة. يوصى باستخدام سماعات عازلة للضوضاء في المستقبل.', 'date' => '2024-05-02', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'أكمل يوسف جميع المهام المكلف بها بشكل مستقل. تقدم ممتاز هذا الأسبوع',             'date' => '2024-05-03', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],

            // Parent Mohammad (user 4) notes on his kids
            ['note' => 'نام عمر جيدًا الليلة الماضية. تناول الإفطار بشكل مستقل هذا الصباح..',                        'date' => '2024-05-04', 'Userid' => 4, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => ' كانت لينا منزعجة عندما غيرنا روتينها الصباحي. سنحاول الحفاظ على الثبات',          'date' => '2024-05-04', 'Userid' => 4, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
