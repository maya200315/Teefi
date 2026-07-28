<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ChildProfileController extends Controller
{
    // قائمة كل أطفال الأهل المسجّل دخوله
    public function index(Request $request)
    {
        $children = $request->user()->children()->select('id', 'name')->get();

        return response()->json($children);
    }

    // بيانات طفل معين (اسم، عمر، مستوى توحد) 
    public function show(Request $request, int $childId)
    {
        //  بتتأكد إنه الطفل فعلاً تابع لهالأهل، ما بتسمح لأهل تاني يشوف طفل مش طفله
        $child = $request->user()->children()->where('id', $childId)->first();

        if (!$child) {
            return response()->json([
                'message' => 'Child not found or not linked to this account.'
            ], 404);
        }

        return response()->json([
            'id'           => $child->id,
            'name'         => $child->name,
            'age'          => $child->age,
            'autism_level' => $child->autism_level,
        ]);
    }
}