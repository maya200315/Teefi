<?php

namespace Database\Seeders;

use App\Models\Complaint;
use App\Models\Parentt;
use Illuminate\Database\Seeder;

class ComplaintSeeder extends Seeder
{
    public function run(): void
    {
        // ياخد كل الأهل الموجودين بالجدول ويعمل شكوى لكل وحد منهم
        $parents = Parentt::with('user')->get();

        if ($parents->isEmpty()) {
            $this->command->info('لا يوجد أهل بالجدول، أضف أهل أولاً قبل تشغيل هاد الـ seeder.');
            return;
        }

        $sampleComplaints = [
            ['title' => 'مشكلة بتسجيل الدخول', 'message' => 'ما عم قدر أسجل دخول من كذا يوم.'],
            ['title' => 'اقتراح تحسين', 'message' => 'بحب لو تضيفو إشعارات عند وصول تقرير جديد.'],
            ['title' => 'استفسار عن الأخصائي', 'message' => 'بدي غيّر الأخصائي المرتبط بابني.'],
        ];

        foreach ($parents as $parentt) {
            Complaint::create([
                'Userid'  => $parentt->user_id,
                'title'   => $sampleComplaints[array_rand($sampleComplaints)]['title'],
                'message' => $sampleComplaints[array_rand($sampleComplaints)]['message'],
            ]);
        }
    }
}