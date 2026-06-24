<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class TestUserSeeder extends Seeder
{
    public function run(): void
    {
        // Admin
        $user = new User();
        $user->name = 'Admin User';
        $user->mobile_number = '0999999999';
        $user->password = Hash::make('123456');
        $user->Roleid = 1;
        $user->save();

        // Specialists
        $user = new User();
        $user->name = 'Dr. Sara Ahmad';
        $user->mobile_number = '0911000002';
        $user->password = Hash::make('333333');
        $user->Roleid = 2;
        $user->save();

        $user = new User();
        $user->name = 'Dr. Khaled Nasser';
        $user->mobile_number = '0911000003';
        $user->password = Hash::make('222222');
        $user->Roleid = 2;
        $user->save();

        // Parents
        $user = new User();
        $user->name = 'Mohammad Ali';
        $user->mobile_number = '0911000004';
        $user->password = Hash::make('000000');
        $user->Roleid = 3;
        $user->save();

        $user = new User();
        $user->name = 'Fatima Hassan';
        $user->mobile_number = '0911000005';
        $user->password = Hash::make('111111');
        $user->Roleid = 3;
        $user->save();
    }
}