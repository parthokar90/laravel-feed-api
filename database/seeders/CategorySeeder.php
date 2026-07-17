<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create();

        // 50 real-world software/interview oriented tech titles
        $techCategories = [
            'Laravel Framework', 'React.js', 'Next.js Frontend',
            'Python Programming', 'FastAPI Microservice',
        ];

        foreach ($techCategories as $index => $name) {
            $description = $faker->sentence(12) . " Explores comprehensive interview questions, edge cases, and conceptual deep dives regarding " . $name . ".";

            Category::create([
                'name'        => $name,
                'description' => $description,
                'created_at'  => now(),
                'updated_at'  => now(),
            ]);
        }
    }
}