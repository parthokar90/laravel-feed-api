<?php

namespace App\Http\Controllers\Api\V1\Topic;

use App\Http\Controllers\Controller;
use App\Models\Topic; 
use App\Http\Requests\Api\V1\Topic\StoreTopicRequest;
use App\Http\Requests\Api\V1\Topic\UpdateTopicRequest;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Exception;

class TopicController extends Controller
{
    use ApiResponse;

    /**
     * Display a listing of the topics.
     */
    public function index(): JsonResponse
    {
        try {
            $topics = Topic::latest()->get();
            return $this->successResponse($topics, 'Topics fetched successfully');
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Store a newly created topic in storage.
     */
    public function store(StoreTopicRequest $request): JsonResponse
    {
        try {
            $topic = Topic::create($request->validated());
            return $this->successResponse($topic, 'Topic created successfully', 201);
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Display the specified topic.
     */
    public function show($id): JsonResponse
    {
        try {
            $topic = Topic::find($id);

            if (!$topic) {
                return $this->errorResponse('Topic not found', 404);
            }

            return $this->successResponse($topic, 'Topic details fetched successfully');
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Update the specified topic in storage.
     */
    public function update(UpdateTopicRequest $request, $id): JsonResponse
    {
        try {
            $topic = Topic::find($id);

            if (!$topic) {
                return $this->errorResponse('Topic not found', 404);
            }

            $topic->update($request->validated());
            return $this->successResponse($topic, 'Topic updated successfully');
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Remove the specified topic from storage.
     */
    public function destroy($id): JsonResponse
    {
        try {
            $topic = Topic::find($id);

            if (!$topic) {
                return $this->errorResponse('Topic not found', 404);
            }

            $topic->delete();
            return $this->successResponse(null, 'Topic deleted successfully');
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }

    /**
     * Custom Method: Get topics by Category ID
     * Route: GET /api/v1/get-topic-details/{cat_id}
     */
    public function getCategoryTopic($cat_id): JsonResponse
    {
        try {
            $topics = Topic::where('category_id', $cat_id)->get();

            if ($topics->isEmpty()) {
                return $this->errorResponse('No topics found for this category', 404);
            }

            return $this->successResponse($topics, 'Category topics fetched successfully');
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage(), 500);
        }
    }
}
