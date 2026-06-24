<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PecsCardChildSeeder extends Seeder
{
    public function run(): void
    {
        // Assign cards to children based on their needs
        DB::table('pecs_card_child')->insert([
            // Omar Ali (child 1) — Food & Emotions cards
            ['PECS_cardid' => 1,  'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Water
            ['PECS_cardid' => 2,  'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Milk
            ['PECS_cardid' => 5,  'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Happy
            ['PECS_cardid' => 6,  'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Sad
            ['PECS_cardid' => 11, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Eat
            ['PECS_cardid' => 16, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()], // Mom

            // Lina Ali (child 2) — Daily Activities & Places cards
            ['PECS_cardid' => 3,  'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // Apple
            ['PECS_cardid' => 9,  'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // Sleep
            ['PECS_cardid' => 10, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // Shower
            ['PECS_cardid' => 13, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // Home
            ['PECS_cardid' => 14, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // School
            ['PECS_cardid' => 17, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()], // Dad

            // Youssef Hassan (child 3) — All categories
            ['PECS_cardid' => 1,  'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Water
            ['PECS_cardid' => 5,  'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Happy
            ['PECS_cardid' => 7,  'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Angry
            ['PECS_cardid' => 12, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Play
            ['PECS_cardid' => 15, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Hospital
            ['PECS_cardid' => 18, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()], // Doctor
        ]);
    }
}
