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
            ['name' => 'التحفيز الذاتي(Stimming)',  'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'العدوان',                   'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'الاتصال البصري ',                  'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'التواصل اللفظي',         'Userid' => 2, 'created_at' => now(), 'updated_at' => now()],
            // Created by Specialist Dr. Khaled (user 3)
            ['name' => 'التفاعل الاجتماعي',           'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'انهيار السلوك',                     'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'السلوك المتكرر',          'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'إنهاء المهمة',              'Userid' => 3, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
