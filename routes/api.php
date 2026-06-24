<?php

use App\Http\Controllers\Api\Admin\AdminDashboardController;
use App\Http\Controllers\Api\Admin\ManageUsersController;
use App\Http\Controllers\LoginController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [LoginController::class, 'login']);

Route::middleware(['auth:sanctum'])->prefix('admin')->group(function () {
 
    // ── Dashboard ──────────────────────────────────────────────────────────
    // GET /api/admin/dashboard
    Route::get('dashboard', [AdminDashboardController::class, 'index']);
 
    //  Manage Users 

    Route::get   ('users/{type}',      [ManageUsersController::class, 'index']);
    Route::get   ('users/{type}/{id}', [ManageUsersController::class, 'show']);
    Route::post  ('users/{type}',      [ManageUsersController::class, 'store']);
    Route::put   ('users/{type}/{id}', [ManageUsersController::class, 'update']);
    Route::delete('users/{type}/{id}', [ManageUsersController::class, 'destroy']);
});


