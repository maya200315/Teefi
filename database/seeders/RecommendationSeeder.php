<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class RecommendationSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('recommendations')->insert([
            [
                'text' => 'مراجعة السلوك اليومي للطفل',
                'date' => Carbon::today(),
                'Userid' => 1,
                'Childid' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}