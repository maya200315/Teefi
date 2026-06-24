<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ArticleSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('articles')->insert([
            [
                'title'      => 'فهم اضطراب طيف التوحد
',
                'content'    => 'اضطراب طيف التوحد (ASD) هو حالة تطويرية معقدة تتضمن تحديات مستمرة في التواصل الاجتماعي، واهتمامات محدودة، وسلوكيات متكررة.
',
                'datetime'   => '2024-01-10',
                'Userid'     => 2, // Specialist: Dr. Sara
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title'      => 'PECS:أداة تواصل للأطفال المصابين بالتوحد',
                'content'    => 'نظام تبادل الصور (PECS) هو استراتيجية تكميلية وبدائل للتواصل تُستخدم مع الأطفال والبالغين الذين يعانون من قلة أو عدم وجود قدرة على الكلام.',
                'datetime'   => '2024-02-15',
                'Userid'     => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title'      => 'تحليل السلوك التطبيقي في علاج التوحد',
                'content'    => 'تحليل السلوك التطبيقي (ABA) هو علاج يعتمد على علم التعلم والسلوك. يساعد في زيادة المهارات المفيدة وتقليل السلوكيات التي قد تعرقل التعلم.',
                'datetime'   => '2024-03-20',
                'Userid'     => 3, // Specialist: Dr. Khaled
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title'      => 'Tips for Parents of Autistic Children',
                'content'    => 'Parenting a child with autism can be challenging but also rewarding. Here are practical strategies to support your child\'s development at home.',
                'datetime'   => '2024-04-05',
                'Userid'     => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
