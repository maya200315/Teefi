<?php

use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\BehaviorController;
use App\Http\Controllers\BehaviorTypeController;
use App\Http\Controllers\ChildProfileController;
use App\Http\Controllers\ManageUsersController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\LogoutController;
use App\Http\Controllers\PecsCardCategoryController;
use App\Http\Controllers\PecsCardChildController;
use App\Http\Controllers\PecsCardController;
use App\Http\Controllers\PecsCardParentController;
use App\Http\Controllers\RecommendationController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\SpecialistController;
use App\Http\Controllers\UserArticleController;
use App\Http\Controllers\UserHomeController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [LoginController::class, 'login']);
Route::middleware('auth:sanctum')->post('/logout', [LogoutController::class, 'logout']);
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

  // PECS Card Categories  (واحهة 3)

  Route::get('/pecs-card-categories',         [PecsCardCategoryController::class, 'index']);
  Route::get('/pecs-card-categories/{id}',    [PecsCardCategoryController::class, 'show']);
  Route::post('/pecs-card-categories',        [PecsCardCategoryController::class, 'store']);
  Route::put('/pecs-card-categories/{id}',    [PecsCardCategoryController::class, 'update']);
  Route::delete('/pecs-card-categories/{id}', [PecsCardCategoryController::class, 'destroy']);


  // Route::get('/pecs-cards',         [PecsCardController::class, 'index']);
  Route::get('/pecs-cards/{id}',    [PecsCardController::class, 'show']);
  Route::post('/pecs-cards',        [PecsCardController::class, 'store']);
  Route::put('/pecs-cards/{id}',    [PecsCardController::class, 'update']);
  Route::delete('/pecs-cards/{id}', [PecsCardController::class, 'destroy']);
});

// ----------------------------------------------------------
// routes/api.php
Route::middleware(['auth:sanctum'])->prefix('user')->group(function () {

  // ── Home Screen ──
  Route::get('/home', [UserHomeController::class, 'index']);

  // Articles (مكتبة)
  Route::get('/articles',      [UserArticleController::class, 'index']);
  Route::get('/articles/{id}', [UserArticleController::class, 'show']);

  // ---- أهل ----
  Route::get('/pecs-categories', [PecsCardParentController::class, 'indexForParents']);
  Route::get('/pecs-categories/{id}/cards', [PecsCardParentController::class, 'cardsForParents']);

  // الأنواع الأربعة الثابتة (نوبة غضب / تفاعل إيجابي / سلوك تكراري / استجابة)
  // تستخدميه لتعبئة البطاقات الأربعة بالشاشة
  Route::get('/behavior-types', [BehaviorTypeController::class, 'index']);

  // حفظ تسجيل سلوك جديد (لما اليوزر يختار بطاقة ويكتب ملاحظة ويضغط حفظ)
  //اليوزر كاتب هون ملاحظة بدنا ياها ترجع على شاشة التقرير تبع الاخصائي
  Route::post('/behaviors', [BehaviorController::class, 'store']);

  // كل سجلات السلوك لطفل معيّن (للتقارير)
  Route::get('/children/{childId}/behaviors', [BehaviorController::class, 'reportByChild']);

  // بيانات الطفل (الاسم، العمر، مستوى التوحد) - لهيدر شاشة Record Behavior
  Route::get('/children', [ChildProfileController::class, 'index']);
  Route::get('/children/{childId}/profile', [ChildProfileController::class, 'show']);

  Route::get('children/{childId}/reports/weekly', [ReportController::class, 'weekly']);
  Route::get('children/{childId}/reports/monthly', [ReportController::class, 'monthly']);
  Route::get('children/{childId}/reports/chart', [ReportController::class, 'chart']);

  Route::get('children/{childId}/recommendations', [RecommendationController::class, 'index']);
  Route::post('children/{childId}/recommendations', [RecommendationController::class, 'store']);
  Route::put('recommendations/{id}', [RecommendationController::class, 'update']);
  Route::delete('recommendations/{id}', [RecommendationController::class, 'destroy']);
});

Route::middleware(['auth:sanctum'])->prefix('specialist')->group(function () {
  Route::get('MyChildren', [SpecialistController::class, 'myChildren']);
  Route::post('children/{childId}/recommendations', [RecommendationController::class, 'store']);
  
});
