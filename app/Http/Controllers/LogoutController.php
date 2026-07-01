<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class LogoutController extends Controller
{
public function logout(Request $request)
{
    $user = $request->user();

    if (!$user) {
        return response()->json(['message' => 'Unauthenticated'], 401);
    }

    $user->currentAccessToken()->delete();

    return response()->json(['message' => 'Logged out successfully'], 200);
}
}
