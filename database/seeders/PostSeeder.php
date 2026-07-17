<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PostSeeder extends Seeder
{
    public function run(): void
    {
        $faker = \Faker\Factory::create();

        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        DB::table('posts')->truncate();
        
        $totalRecords = 100000; 
        $chunkSize = 5000;     
        $posts = [];

        for ($i = 1; $i <= $totalRecords; $i++) {
            $date = $faker->dateTimeBetween('-1 year', 'now')->format('Y-m-d H:i:s');

            $attachmentUrl = 'https://picsum.photos/id/' . $faker->numberBetween(1, 200) . '/640/480';

            $posts[] = [
                'user_id' => 1,
                'title' => $faker->sentence(10),
                'attachment' => $attachmentUrl, 
                'visibility' => 'public',
                'likes_count' => $faker->numberBetween(0, 500),
                'comments_count' => $faker->numberBetween(0, 100),
                'created_at' => $date,
                'updated_at' => $date,
            ];

            if ($i % $chunkSize === 0) {
                DB::table('posts')->insert($posts);
                $posts = []; 
            }
        }

        if (!empty($posts)) {
            DB::table('posts')->insert($posts);
        }
    }
}