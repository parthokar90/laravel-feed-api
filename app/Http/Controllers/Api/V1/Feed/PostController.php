<?php

namespace App\Http\Controllers\Api\V1\Feed;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\V1\Feed\StorePostRequest;
use App\Http\Resources\Api\V1\PostResource;
use App\Models\Post;
use App\Services\V1\PostService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class PostController extends Controller
{
    public function __construct(private PostService $postService) {}

    public function store(StorePostRequest $request): JsonResponse
    {
        try {
            $post = $this->postService->create(
                $request->validated(),
                $request->user()->id
            );

            return response()->json([
                'success' => true,
                'message' => 'Post created successfully',
                'data'    => new PostResource($post),
            ], 201);
        } catch (Exception $e) {
            Log::error('Post creation failed', [
                'user_id' => $request->user()->id,
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to create post',
            ], 500);
        }
    }

    public function index(Request $request): JsonResponse
    {
        try {
            $posts = Post::with(['user', 'images', 'comments.user', 'comments.replies.user'])
                ->visibleTo($request->user())
                ->latest()
                ->paginate(10);

            return response()->json([
                'success' => true,
                'data'    => PostResource::collection($posts),
                'meta'    => [
                    'current_page' => $posts->currentPage(),
                    'last_page'    => $posts->lastPage(),
                    'total'        => $posts->total(),
                ],
            ]);
        } catch (Exception $e) {
            Log::error('Feed fetch failed', [
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch posts',
            ], 500);
        }
    }

    public function destroy(Request $request, Post $post): JsonResponse
    {
        try {
            if ($post->user_id !== $request->user()->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized',
                ], 403);
            }

            $this->postService->delete($post);

            return response()->json([
                'success' => true,
                'message' => 'Post deleted successfully',
            ]);
        } catch (Exception $e) {
            Log::error('Post deletion failed', [
                'post_id' => $post->id,
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to delete post',
            ], 500);
        }
    }
}
