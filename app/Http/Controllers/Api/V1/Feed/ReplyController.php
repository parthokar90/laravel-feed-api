<?php

namespace App\Http\Controllers\Api\V1\Feed;

use App\Http\Controllers\Controller;
use App\Http\Resources\Api\V1\ReplyResource;
use App\Models\Comment;
use App\Models\Reply;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Exception;

class ReplyController extends Controller
{
    public function store(Request $request, Comment $comment): JsonResponse
    {
        $request->validate(['body' => ['required', 'string', 'max:1000']]);

        try {
            $reply = DB::transaction(function () use ($request, $comment) {
                $reply = Reply::create([
                    'comment_id' => $comment->id,
                    'user_id'    => $request->user()->id,
                    'body'       => $request->body,
                ]);
                $comment->increment('replies_count');
                return $reply->load('user');
            });

            return response()->json([
                'success' => true,
                'data'    => new ReplyResource($reply),
            ], 201);
        } catch (Exception $e) {
            Log::error('Reply creation failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to add reply'], 500);
        }
    }

    public function destroy(Request $request, Reply $reply): JsonResponse
    {
        try {
            if ($reply->user_id !== $request->user()->id) {
                return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
            }
            DB::transaction(function () use ($reply) {
                $reply->comment->decrement('replies_count');
                $reply->delete();
            });
            return response()->json(['success' => true, 'message' => 'Reply deleted']);
        } catch (Exception $e) {
            Log::error('Reply deletion failed', ['message' => $e->getMessage()]);
            return response()->json(['success' => false, 'message' => 'Failed to delete reply'], 500);
        }
    }
}
