<?php

namespace Database\Seeders;

use App\Models\BehaviorType;
use Illuminate\Database\Seeder;

class BehaviorTypeSeeder extends Seeder
{
    public function run(): void
    {
        $types = ['نوبة غضب', 'تفاعل إيجابي', 'سلوك تكراري', 'استجابة'];

        foreach ($types as $name) {
            BehaviorType::firstOrCreate(['name' => $name]); // Userid رح يضل null، مش مشكلة لأنه nullable
        }
    }
}