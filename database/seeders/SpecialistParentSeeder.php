<?php

namespace Database\Seeders;

use App\Models\Child;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class SpecialistParentSeeder extends Seeder
{
    public function run(): void
    {
        // 1) أدمن تجريبي
        $admin = User::firstOrCreate(
            ['mobile_number' => 'admin@test.com'],
            [
                'name'     => 'أدمن تجريبي',
                'password' => Hash::make('password'),
                'Roleid'   => 1,
            ]
        );

        // 2) أخصائي تجريبي
        $specialist = User::firstOrCreate(
            ['mobile_number' => 'specialist@test.com'],
            [
                'name'     => 'أخصائي تجريبي',
                'password' => Hash::make('password'),
                'Roleid'   => 2,
            ]
        );

        // 3) ربط الأهالي بالأخصائي
        $parentIds = Child::whereIn('id', [1, 2, 3])
            ->pluck('Userid')
            ->unique()
            ->filter();

        foreach ($parentIds as $parentId) {
            DB::table('specialist_parent')->updateOrInsert(
                [
                    'Specialistid' => $specialist->id,
                    'Parentid'     => $parentId,
                ],
                [
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );
        }

        $this->command?->info("تم ربط {$parentIds->count()} أهل بالأخصائي التجريبي.");

        // 4) Tokens
        if (method_exists($admin, 'createToken')) {
            $adminToken      = $admin->createToken('postman-admin')->plainTextToken;
            $specialistToken = $specialist->createToken('postman-specialist')->plainTextToken;

            $this->command?->info('=====================================================');
            $this->command?->info("Admin      → mobile: admin@test.com      | token: {$adminToken}");
            $this->command?->info("Specialist → mobile: specialist@test.com | token: {$specialistToken}");
            $this->command?->info('=====================================================');
        } else {
            $this->command?->warn('Sanctum مش مركّب — سجّل دخول من /api/login وخذ الـ token يدوياً.');
        }
    }
}