<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PecsCardCategorySeeder extends Seeder
{
    public function run(): void
    {
        DB::table('pecs_card_categories')->insert([
            ['id' => 1, 'name' => 'Food & Drinks',       'created_at' => now(), 'updated_at' => now()],
            ['id' => 2, 'name' => 'Emotions',           'created_at' => now(), 'updated_at' => now()],
            ['id' => 3, 'name' => 'Daily Activities',  'created_at' => now(), 'updated_at' => now()],
            ['id' => 4, 'name' => 'Places',            'created_at' => now(), 'updated_at' => now()],
            ['id' => 5, 'name' => 'People',           'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
