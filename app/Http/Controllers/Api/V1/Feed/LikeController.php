<?php

namespace App\Http\Controllers\Api\V1\Feed;

use App\Http\Controllers\Controller;
use App\Http\Resources\Api\V1\LikeUserResource;
use App\Models\Comment;
use App\Models\Like;
use App\Models\Post;
use App\Models\Reply;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Exception;

class LikeController extends Controller
{
    private function resolveModel(string $type, int $id)
    {
        return match ($type) {
            'posts'    => Post::findOrFail($id),
            'comments' => Comment::findOrFail($id),
            'replies'  => Reply::findOrFail($id),
        };
    }

    public function toggle(Request $request, string $type, int $id): JsonResponse
    {
        try {
            $model = $this->resolveModel($type, $id);
            $userId = $request->user()->id;

            $liked = DB::transaction(function () use ($model, $userId) {
                $existing = $model->likes()->where('user_id', $userId)->first();

                if ($existing) {
                    $existing->delete();
                    $model->decrement('likes_count');
                    return false;
                }

                $model->likes()->create(['user_id' => $userId]);
                $model->increment('likes_count');
                return true;
            });

            return response()->json([
                'success'     => true,
                'liked'       => $liked,
                'likes_count' => $model->fresh()->likes_count,
            ]);
        } catch (Exception $e) {
            Log::error('Like toggle failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to toggle like'], 500);
        }
    }

    public function index(Request $request, string $type, int $id): JsonResponse
    {
        try {
            $model = $this->resolveModel($type, $id);
            $likes = $model->likes()->with('user')->latest()->get();

            return response()->json([
                'success' => true,
                'data'    => LikeUserResource::collection($likes),
            ]);
        } catch (Exception $e) {
            Log::error('Likes fetch failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to fetch likes'], 500);
        }
    }
}
