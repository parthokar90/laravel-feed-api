<?php

namespace App\Http\Controllers\Api\V1\Post;

use App\Http\Controllers\Controller;

use Illuminate\Http\Request;

use App\Models\Post;

use App\Http\Requests\Api\V1\Post\StorePostRequest;

use Illuminate\Http\JsonResponse;

use App\Traits\ApiResponse;

use App\Traits\FileUpload;

use Exception;

class PostController extends Controller
{
    // Inject both traits for response mapping and asset uploading
    use ApiResponse, FileUpload;

    /**
     * Display a listing of the resource using high-performance cursor pagination.
     *
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $perPage = min($request->integer('per_page', 10), 50);

             $posts = Post::with('user:id,first_name,last_name,avatar')
                ->latest('id')
                ->cursorPaginate($perPage);

            return $this->successResponse($posts, 'Posts fetched successfully');
            
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Store a newly created post in storage.
     *
     * @param StorePostRequest $request
     * @return JsonResponse
     */
    public function store(StorePostRequest $request): JsonResponse
    {
        try {
            $validated = $request->validated();

            // Handle attachment upload using the custom Trait
            $validated['attachment'] = $this->uploadToSupabase($request->file('attachment'));

            // Inject the authenticated user ID into the creation dataset
            $validated['user_id'] = auth()->id();

            // Create post instance in database safely via fillable
            $post = Post::create($validated);

            return $this->successResponse($post, 'Post created successfully', 201);
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }
}
