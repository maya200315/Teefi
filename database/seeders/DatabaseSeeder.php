<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            RoleSeeder::class,
            TestUserSeeder::class,
            ChildSeeder::class,
            ArticleSeeder::class,
            PecsCardCategorySeeder::class,
            PecsCardSeeder::class,
            PecsCardChildSeeder::class,
            BehaviorTypeSeeder::class,
            BehaviorSeeder::class,
            DailyNoteSeeder::class,
            WeeklyReportSeeder::class,
            RecommendationSeeder::class,
        ]);
    }
}
