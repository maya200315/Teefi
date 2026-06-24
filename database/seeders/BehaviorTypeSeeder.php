<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BehaviorTypeSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('behavior_types')->insert([
            // Created by Specialist Dr. Sara (user 2)
            ['name' => 'Self-Stimulatory (Stimming)',  'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Aggression',                   'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Eye Contact',                  'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Verbal Communication',         'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            // Created by Specialist Dr. Khaled (user 3)
            ['name' => 'Social Interaction',           'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Meltdown',                     'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Repetitive Behavior',          'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Task Completion',              'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
