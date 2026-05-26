<?php

namespace App\Http\Controllers\Api\V1\Feed;

use App\Http\Controllers\Controller;
use App\Http\Resources\Api\V1\CommentResource;
use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Exception;

class CommentController extends Controller
{
    public function store(Request $request, Post $post): JsonResponse
    {
        $request->validate(['body' => ['required', 'string', 'max:1000']]);

        try {
            $comment = DB::transaction(function () use ($request, $post) {
                $comment = Comment::create([
                    'post_id' => $post->id,
                    'user_id' => $request->user()->id,
                    'body'    => $request->body,
                ]);
                $post->increment('comments_count');
                return $comment->load('user');
            });

            return response()->json([
                'success' => true,
                'data'    => new CommentResource($comment),
            ], 201);
        } catch (Exception $e) {
            Log::error('Comment creation failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to add comment'], 500);
        }
    }

    public function destroy(Request $request, Comment $comment): JsonResponse
    {
        try {
            if ($comment->user_id !== $request->user()->id) {
                return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
            }
            DB::transaction(function () use ($comment) {
                $comment->post->decrement('comments_count');
                $comment->delete();
            });
            return response()->json(['success' => true, 'message' => 'Comment deleted']);
        } catch (Exception $e) {
            Log::error('Comment deletion failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to delete comment'], 500);
        }
    }
}
