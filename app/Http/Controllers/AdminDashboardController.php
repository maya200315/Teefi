<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Article;
use App\Models\PecsCard;
use Illuminate\Http\JsonResponse;

class AdminDashboardController extends Controller
{
    /**
     * GET /api/admin/dashboard
     * Returns live counts for the admin dashboard cards.
     */
    public function index(): JsonResponse
    {
        $stats = [
            'parents_count'     => User::where('Roleid', 3)->count(),
            'specialists_count' => User::where('Roleid', 2)->count(),
            'articles_count'    => Article::count(),
            'pecs_cards_count'  => PecsCard::count(),
        ];

        return response()->json([
            'success' => true,
            'data'    => $stats,
        ]);
    }
}