<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserHomeController extends Controller
{public function index(Request $request)
{
    $user = $request->user();
    $child = $user->children()->first();

    if (!$child) {
        return response()->json([
            'message' => 'No data found.'
        ], 404);
    }

    return response()->json([
        'child' => [
            'id' => $child->id,
            'name' => $child->name,
            'age' => $child->age,
            'autism_level' => $child->autism_level,
        ],
        'quick_actions' => [
            ['key' => 'behavior', 'label' => 'Behavior'],
            ['key' => 'reports', 'label' => 'Reports'],
            ['key' => 'pecs', 'label' => 'PECS'],
            ['key' => 'library', 'label' => 'Library'],
        ],
    ]);
}
}
