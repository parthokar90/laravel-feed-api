<?php 
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\V1\Category\CategoryController;

Route::prefix('v1')->group(function () {

    // Protected Routes
    Route::middleware('auth:sanctum')->group(function () {

        Route::apiResource('categories', CategoryController::class);

    });

    Route::get('category-index',[CategoryController::class,'index']);
});