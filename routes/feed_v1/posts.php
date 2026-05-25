<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\Feed\PostController;
use App\Http\Controllers\Api\V1\Feed\CommentController;
use App\Http\Controllers\Api\V1\Feed\ReplyController;
use App\Http\Controllers\Api\V1\Feed\LikeController;

Route::prefix('v1')->group(function () {

    // Protected Routes
    Route::middleware('auth:sanctum')->group(function () {

        // Posts
        Route::apiResource('posts', PostController::class);

        // Comments
        Route::apiResource('posts.comments', CommentController::class)
            ->shallow();

        // Replies
        Route::apiResource('comments.replies', ReplyController::class)
            ->shallow();

        // Likes — polymorphic
        Route::post('{type}/{id}/like',   [LikeController::class, 'toggle'])
            ->where('type', 'posts|comments|replies');

        // Who liked
        Route::get('{type}/{id}/likes',   [LikeController::class, 'index'])
            ->where('type', 'posts|comments|replies');
    });
});
