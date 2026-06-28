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
        $parent = new Parentt();
        $parent->user_id = $mohammad->id;
        $parent->autism_level = 'mild';
        $parent->specialist_id = $sara->id;
        $parent->age = 5;
        $parent->save();

        $fatima = User::where('mobile_number', '0911000005')->first();
        $parent = new Parentt();
        $parent->user_id = $fatima->id;
        $parent->autism_level = 'severe';
        $parent->specialist_id = $khaled->id;
        $parent->age = 10;
        $parent->save();
    }
}