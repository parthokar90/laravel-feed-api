<?php

namespace Database\Factories;

use App\Models\Post;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Carbon; 

class PostFactory extends Factory
{
    protected $model = Post::class;

    public function definition(): array
    {
        $createdAt = Carbon::parse($this->faker->dateTimeBetween('-1 year', 'now'));
        

        return [
            'user_id' => 1, 
            'title' => $this->faker->sentence(10),
            'attachment' => $this->faker->imageUrl(), 
            'visibility' => 'public',
            'likes_count' => $this->faker->numberBetween(0, 500),
            'comments_count' => $this->faker->numberBetween(0, 100),
            
            'created_at' => $createdAt->format('Y-m-d H:i:s'),
            'updated_at' => $createdAt->format('Y-m-d H:i:s'),
        ];
    }
}