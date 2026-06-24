<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BehaviorSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('behaviors')->insert([
            // Omar Ali (child 1)
            ['date' => '2024-05-01', 'notes' => 'Showed stimming for 10 minutes during class.',            'Behavior_typeid' => 1, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'Made eye contact with teacher twice today.',              'Behavior_typeid' => 3, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'Used 3 PECS cards to request food independently.',        'Behavior_typeid' => 4, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'Completed task without prompting — great progress!',     'Behavior_typeid' => 8, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-05', 'notes' => 'Had a meltdown after routine change.',                   'Behavior_typeid' => 6, 'Childid' => 1, 'created_at' => now(), 'updated_at' => now()],

            // Lina Ali (child 2)
            ['date' => '2024-05-01', 'notes' => 'Aggressive behavior toward peers during group activity.', 'Behavior_typeid' => 2, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'Engaged in 5 minutes of social play with another child.', 'Behavior_typeid' => 5, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'Repetitive hand-flapping observed for 20 minutes.',      'Behavior_typeid' => 7, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'Communicated need verbally for the first time.',         'Behavior_typeid' => 4, 'Childid' => 2, 'created_at' => now(), 'updated_at' => now()],

            // Youssef Hassan (child 3)
            ['date' => '2024-05-01', 'notes' => 'Calm session, participated in group activity.',           'Behavior_typeid' => 5, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-02', 'notes' => 'Task completion improved significantly today.',           'Behavior_typeid' => 8, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-03', 'notes' => 'Meltdown triggered by loud noise in the hallway.',       'Behavior_typeid' => 6, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['date' => '2024-05-04', 'notes' => 'Stimming reduced compared to last week.',                'Behavior_typeid' => 1, 'Childid' => 3, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
