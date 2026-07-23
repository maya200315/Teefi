<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            BehaviorTypeSeeder::class,
            RoleSeeder::class,
            TestUserSeeder::class,
            ChildSeeder::class,
            ArticleSeeder::class,
            PecsCardCategorySeeder::class,
            PecsCardSeeder::class,
            PecsCardChildSeeder::class,
            BehaviorSeeder::class,
            DailyNoteSeeder::class,
            WeeklyReportSeeder::class,
            RecommendationSeeder::class,
            SpecialistSeeder::class,
            ParentSeeder::class,
        ]);
    }
}
