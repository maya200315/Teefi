<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class SuperAdminSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
            ['mobile_number' => '0968879073'], // غيّرها لرقم حقيقي
            [
                'name'          => 'Boss MH',
                'password'      => Hash::make('23102003'),
                'Roleid'        => 4,
            ]
        );
    }
}