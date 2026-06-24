<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PecsCardSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('pecs_cards')->insert([
            // Food & Drinks (category 1)
            ['title' => 'Water',    'image' => 'pecs/water.png',    'PECS_card_categoryid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Milk',     'image' => 'pecs/milk.png',     'PECS_card_categoryid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Apple',    'image' => 'pecs/apple.png',    'PECS_card_categoryid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Bread',    'image' => 'pecs/bread.png',    'PECS_card_categoryid' => 1, 'created_at' => now(), 'updated_at' => now()],
            // Emotions (category 2)
            ['title' => 'Happy',    'image' => 'pecs/happy.png',    'PECS_card_categoryid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Sad',      'image' => 'pecs/sad.png',      'PECS_card_categoryid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Angry',    'image' => 'pecs/angry.png',    'PECS_card_categoryid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Tired',    'image' => 'pecs/tired.png',    'PECS_card_categoryid' => 2, 'created_at' => now(), 'updated_at' => now()],
            // Daily Activities (category 3)
            ['title' => 'Sleep',    'image' => 'pecs/sleep.png',    'PECS_card_categoryid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Shower',   'image' => 'pecs/shower.png',   'PECS_card_categoryid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Eat',      'image' => 'pecs/eat.png',      'PECS_card_categoryid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Play',     'image' => 'pecs/play.png',     'PECS_card_categoryid' => 3, 'created_at' => now(), 'updated_at' => now()],
            // Places (category 4)
            ['title' => 'Home',     'image' => 'pecs/home.png',     'PECS_card_categoryid' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'School',   'image' => 'pecs/school.png',   'PECS_card_categoryid' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Hospital', 'image' => 'pecs/hospital.png', 'PECS_card_categoryid' => 4, 'created_at' => now(), 'updated_at' => now()],
            // People (category 5)
            ['title' => 'Mom',      'image' => 'pecs/mom.png',      'PECS_card_categoryid' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Dad',      'image' => 'pecs/dad.png',      'PECS_card_categoryid' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['title' => 'Doctor',   'image' => 'pecs/doctor.png',   'PECS_card_categoryid' => 5, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
