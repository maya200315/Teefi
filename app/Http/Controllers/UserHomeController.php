<?php

namespace App\Http\Controllers;  

use App\Http\Controllers\Controller;
use App\Models\Child;
use App\Models\Article;
use Illuminate\Http\Request;

class UserHomeController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        // جيب أول طفل مرتبط بالأهل
        $child = Child::where('Userid', $user->id)->first();

        if (!$child) {
            return response()->json([
                'message' => 'No child found for this user.'
            ], 404);
        }

    
        return response()->json([
            'child' => [
                'id'           => $child->id,
                'name'         => $child->name,
                'age'          => $child->age,
                'autism_level' => $child->autism_level,
            ],
            'quick_actions' => [
                ['key' => 'behavior', 'label' => 'Behavior'],
                ['key' => 'reports',  'label' => 'Reports'],
                ['key' => 'pecs',     'label' => 'PECS'],
                ['key' => 'library',  'label' => 'Library'],
            ],
        ]);
    }
}