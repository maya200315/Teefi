<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RecommendationSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('recommendations')->insert([
            // Dr. Sara recommendations for Omar
            [
                'text'       => 'Maintain a consistent daily schedule using visual timetables to reduce anxiety and meltdowns related to transitions.',
                'date'       => '2024-05-05',
                'Userid'     => 2,
                'Childid'    => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'Increase PECS training sessions to twice daily. Focus on requesting food and expressing emotions.',
                'date'       => '2024-05-06',
                'Userid'     => 2,
                'Childid'    => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Dr. Sara recommendations for Lina
            [
                'text'       => 'Introduce sensory-friendly tools such as fidget toys to help Lina self-regulate during group activities.',
                'date'       => '2024-05-05',
                'Userid'     => 2,
                'Childid'    => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'Implement a social stories program to help Lina understand appropriate interaction with peers and reduce aggression.',
                'date'       => '2024-05-06',
                'Userid'     => 2,
                'Childid'    => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Dr. Khaled recommendations for Youssef
            [
                'text'       => 'Provide noise-canceling headphones for use in the classroom to minimize sensory overload from environmental sounds.',
                'date'       => '2024-05-05',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'Continue reinforcing task-completion behavior using a token reward system. Youssef responds well to positive reinforcement.',
                'date'       => '2024-05-06',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'text'       => 'Schedule monthly progress meetings with parents to align home and therapy strategies for consistent behavioral outcomes.',
                'date'       => '2024-05-07',
                'Userid'     => 3,
                'Childid'    => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
