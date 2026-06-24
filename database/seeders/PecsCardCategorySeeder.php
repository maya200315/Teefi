<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PecsCardCategorySeeder extends Seeder
{
    public function run(): void
    {
        DB::table('pecs_card_categories')->insert([
            ['id' => 1, 'name' => 'Food & Drinks',    'code' => 100, 'created_at' => now(), 'updated_at' => now()],
            ['id' => 2, 'name' => 'Emotions',         'code' => 200, 'created_at' => now(), 'updated_at' => now()],
            ['id' => 3, 'name' => 'Daily Activities', 'code' => 300, 'created_at' => now(), 'updated_at' => now()],
            ['id' => 4, 'name' => 'Places',           'code' => 400, 'created_at' => now(), 'updated_at' => now()],
            ['id' => 5, 'name' => 'People',           'code' => 500, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
