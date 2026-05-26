<?php

namespace App\Services\V1;

use App\Models\Post;
use App\Models\PostImage;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class PostService
{
    public function create(array $data, int $userId): Post
    {
        return DB::transaction(function () use ($data, $userId) {

            $post = Post::create([
                'user_id'    => $userId,
                'title'      => $data['title'],
                'visibility' => $data['visibility'] ?? 'public',
            ]);

            if (!empty($data['images'])) {
                $this->uploadImages($post, $data['images']);
            }

            return $post->load(['user', 'images']);
        });
    }

    private function uploadImages(Post $post, array $images): void
    {
        foreach ($images as $order => $image) {
            /** @var UploadedFile $image */
            $key = $this->generateKey($post->id, $image);

            Storage::disk('s3')->put($key, file_get_contents($image), 'public');

            $baseUrl = rtrim(env('AWS_URL'), '/');

            $url = $baseUrl . '/' . env('AWS_BUCKET') . '/' . $key;

            PostImage::create([
                'post_id' => $post->id,
                'url'     => $url,
                'key'     => $key,
                'order'   => $order,
            ]);
        }
    }

    private function generateKey(int $postId, UploadedFile $file): string
    {
        $ext = $file->getClientOriginalExtension();
        $uuid = Str::uuid();
        return "posts/{$postId}/{$uuid}.{$ext}";
    }

    public function delete(Post $post): void
    {
        DB::transaction(function () use ($post) {

            foreach ($post->images as $image) {
                Storage::disk('s3')->delete($image->key);
            }

            $post->delete();
        });
    }
}
