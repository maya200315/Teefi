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
                'title'      => 'Understanding Autism Spectrum Disorder',
                'content'    => 'Autism Spectrum Disorder (ASD) is a complex developmental condition involving persistent challenges with social communication, restricted interests, and repetitive behavior.',
                'datetime'   => '2024-01-10',
                'Userid'     => 2, // Specialist: Dr. Sara
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title'      => 'PECS: A Communication Tool for Children with Autism',
                'content'    => 'The Picture Exchange Communication System (PECS) is an augmentative and alternative communication strategy used with children and adults who have limited or no speech ability.',
                'datetime'   => '2024-02-15',
                'Userid'     => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title'      => 'Applied Behavior Analysis in Autism Therapy',
                'content'    => 'Applied Behavior Analysis (ABA) is a therapy based on the science of learning and behavior. It helps increase useful skills and decrease behaviors that may interfere with learning.',
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
