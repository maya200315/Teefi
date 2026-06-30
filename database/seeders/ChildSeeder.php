<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ChildSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('children')->insert([
            [
                'name'         => 'Omar Ali',
                'age'          => 7,
                'autism_level' => 'Mild',
                'Userid'       => 4, // Parent: Mohammad Ali
                'created_at'   => now(),
                'updated_at'   => now(),
            ],
            [
                'name'         => 'Lina Ali',
                'age'          => 5,
                'autism_level' => 'Moderate',
                'Userid'       => 4,
                'created_at'   => now(),
                'updated_at'   => now(),
            ],
            [
                'name'         => 'Youssef Hassan',
                'age'          => 9,
                'autism_level' => 'Severe',
                'Userid'       => 5, // Parent: Fatima Hassan
                'created_at'   => now(),
                'updated_at'   => now(),
            ],
        ]);
    }
}
