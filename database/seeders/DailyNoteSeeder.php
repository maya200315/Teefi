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
            ['note' => 'Omar was calm today and responded well to visual cues. Continue PECS reinforcement.',           'date' => '2024-05-01', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Omar had difficulty transitioning between activities. Used timer to help with transitions.',     'date' => '2024-05-02', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Great session today! Omar initiated communication twice using PECS cards without prompting.',   'date' => '2024-05-03', 'Userid' => 2, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],

            // Dr. Sara notes on Lina
            ['note' => 'Lina showed improvement in eye contact during one-on-one time.',                               'date' => '2024-05-01', 'Userid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Lina became upset during snack time. Possible sensory sensitivity to textures.',               'date' => '2024-05-02', 'Userid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],

            // Dr. Khaled notes on Youssef
            ['note' => 'Youssef engaged well in the social skills group today.',                                       'date' => '2024-05-01', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Youssef struggled with loud environment. Recommend noise-canceling headphones for future use.','date' => '2024-05-02', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Youssef completed all assigned tasks independently. Excellent progress this week.',             'date' => '2024-05-03', 'Userid' => 3, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],

            // Parent Mohammad (user 4) notes on his kids
            ['note' => 'Omar slept well last night. Ate breakfast independently this morning.',                        'date' => '2024-05-04', 'Userid' => 4, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['note' => 'Lina was upset when we changed her morning routine. Will try to keep it consistent.',          'date' => '2024-05-04', 'Userid' => 4, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
