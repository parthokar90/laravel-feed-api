<?php 

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\V1\Topic\TopicController;

Route::prefix('v1')->group(function () {

    // Protected Routes
    Route::middleware('auth:sanctum')->group(function () {

        Route::apiResource('topics', TopicController::class);

    });

    Route::get('get-topic-details/{cat_id}',[TopicController::class,'getCategoryTopic']);

});