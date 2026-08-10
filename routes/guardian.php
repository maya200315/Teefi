<?php

use App\Http\Controllers\Guardian\ReportController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum', 'role:parent'])->prefix('guardian')->group(function () {
    Route::get('children/{childId}/reports/weekly',  [ReportController::class, 'weekly']);
    Route::get('children/{childId}/reports/monthly', [ReportController::class, 'monthly']);

    // type = weekly | monthly
    Route::post('reports/{type}/{reportId}/note', [ReportController::class, 'storeNote']);
});
