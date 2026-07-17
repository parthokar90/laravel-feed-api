<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\V1\Post\PostController;

Route::prefix('v1')->group(function () {

    Route::middleware('auth:sanctum')->group(function () {

        Route::apiResource('posts', PostController::class);

    });
});
