<?php

use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\ManageUsersController;
use App\Http\Controllers\LoginController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [LoginController::class, 'login']);

Route::middleware(['auth:sanctum'])->prefix('admin')->group(function () {

    // ── Dashboard ──
    // واجهة1 
    Route::get('/dashboard', [AdminDashboardController::class, 'index']);

    //  Manage Users 

    Route::get('users/{type}',      [ManageUsersController::class, 'index']);
    Route::get('users/{type}/{id}', [ManageUsersController::class, 'show']);
    Route::post('users/{type}',      [ManageUsersController::class, 'store']);
    Route::put('users/{type}/{id}', [ManageUsersController::class, 'update']);
    Route::delete('users/{type}/{id}', [ManageUsersController::class, 'destroy']);


    //  Manage Article
    
    Route::get('/articles',         [ArticleController::class, 'index']);
    Route::get('/articles/{id}',    [ArticleController::class, 'show']);
    Route::post('/articles',        [ArticleController::class, 'store']);
    Route::put('/articles/{id}',    [ArticleController::class, 'update']);
    Route::delete('/articles/{id}', [ArticleController::class, 'destroy']);
});
