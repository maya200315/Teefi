<?php

use App\Http\Controllers\Specialist\ReportController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum', 'role:specialist'])->prefix('specialist')->group(function () {
    Route::get('children', [ReportController::class, 'children']);

    Route::get('children/{childId}/reports/weekly',  [ReportController::class, 'weekly']);
    Route::get('children/{childId}/reports/monthly', [ReportController::class, 'monthly']);

    // type = weekly | monthly
    Route::post('reports/{type}/{reportId}/recommendation', [ReportController::class, 'storeRecommendation']);
});
