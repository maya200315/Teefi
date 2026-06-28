<?php
// database/seeders/SpecialistSeeder.php
namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Specialist;
use App\Models\User;

class SpecialistSeeder extends Seeder
{
    public function run(): void
    {
        $saraa = User::where('mobile_number', '0911000002')->first();
        $specialist = new Specialist();
        $specialist->user_id = $saraa->id;
        $specialist->specialty = 'Speech Therapy';
        $specialist->save();

        $khaled = User::where('mobile_number', '0911000003')->first();
        $specialist = new Specialist();
        $specialist->user_id = $khaled->id;
        $specialist->specialty = 'Behavior Therapy';
        $specialist->save();
    }
}