<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class TestUserSeeder extends Seeder
{
    public function run(): void
    {
        $user = new User();
        $user->mobile_number = '0999999999';
        $user->name = 'Test User';
        $user->password = Hash::make('123456');
        $user->Roleid = 1;
        $user->save();
    }
}