<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Parentt;
use App\Models\User;
use App\Models\Specialist;

class ParentSeeder extends Seeder
{
    public function run(): void
    {
        $sara = Specialist::where('specialty', 'Speech Therapy')->first();
        $khaled = Specialist::where('specialty', 'Behavior Therapy')->first();

        $mohammad = User::where('mobile_number', '0911000004')->first();
        if ($mohammad && $sara) {
            Parentt::updateOrCreate(
                ['user_id' => $mohammad->id],
                [
                    'autism_level' => 'mild',
                    'specialist_id' => $sara->id,
                    'age' => 5,
                ]
            );
        }

        $fatima = User::where('mobile_number', '0911000005')->first();
        if ($fatima && $khaled) {
            Parentt::updateOrCreate(
                ['user_id' => $fatima->id],
                [
                    'autism_level' => 'severe',
                    'specialist_id' => $khaled->id,
                    'age' => 10,
                ]
            );
        }
    }
}