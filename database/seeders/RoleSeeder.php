<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleSeeder extends Seeder
{
    public function run(): void
{
    $roles = [
        ['id' => 1, 'name' => 'Admin'],
        ['id' => 2, 'name' => 'Specialist'],
        ['id' => 3, 'name' => 'Parent'],
    ];

    foreach ($roles as $role) {
        Role::updateOrCreate(
            ['id' => $role['id']],
            ['name' => $role['name']]
        );
    }
}
}
