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
                'summary'         => 'Omar showed notable improvement in communication this week. PECS card usage increased. Meltdown occurred once due to unexpected routine change.',
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
                'summary'         => 'Lina had mixed results this week. Positive social interactions were observed but aggression toward peers remains a concern. Sensory sensitivities noted.',
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
                'summary'         => 'Youssef had a productive week with strong task completion rates. Meltdown triggered by environmental noise. Recommend sensory accommodations for the classroom.',
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
                'summary'         => 'Omar continues to improve. Stimming reduced significantly. Verbal communication attempts increasing. No major meltdowns this week.',
                'Childid'         => 1,
                'Userid'          => 2,
                'created_at'      => now(),
                'updated_at'      => now(),
            ],
        ]);
    }
}
