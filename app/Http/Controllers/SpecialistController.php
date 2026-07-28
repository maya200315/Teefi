<?php

namespace App\Http\Controllers;

use App\Models\Specialist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SpecialistController extends Controller
{
    /**
     * يرجع اسم الأخصائي (المستخدم الحالي المسجل دخوله)
     * + قائمة الأطفال المسجلين عند الأهالي التابعين له
     */
    public function myChildren(Request $request)
    {
        $user = Auth::user(); 

        $specialist = Specialist::where('user_id', $user->id)->first();

        if (!$specialist) {
            return response()->json([
                'message' => 'This user is not a specialist.',
            ], 404);
        }

        $parents = $specialist->parentts()
            ->with(['user.children']) 
            ->get();

        $children = $parents->flatMap(function ($parentt) {
            return $parentt->user->children->map(function ($child) use ($parentt) {
                return [
                    'id'           => $child->id,
                    'name'         => $child->name,
                    'age'          => $child->age,
                    'autism_level' => $child->autism_level,
                    'parent_name'  => $parentt->user->name,
                ];
            });
        })->values();

        return response()->json([
            'specialist_name' => $user->name,
            'specialty'       => $specialist->specialty,
            'children'        => $children,
        ]);
    }
}