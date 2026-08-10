<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\AuthorizesChildAccess;
use App\Models\Child;
use App\Models\Parentt;
use App\Models\Specialist;
use Illuminate\Http\Request;

class ChildController extends Controller
{
    use AuthorizesChildAccess;

    // GET /api/specialist/children
    public function index(Request $request)
    {
        $specialist = Specialist::where('user_id', $request->user()->id)->first();

        if (!$specialist) {
            return response()->json([
                'status'  => false,
                'message' => 'This user is not a specialist.',
            ], 404);
        }

        $parentUserIds = Parentt::where('specialist_id', $specialist->id)
            ->pluck('user_id');

        $children = Child::whereIn('Userid', $parentUserIds)
            ->select('id', 'name', 'Userid')
            ->get();

        return response()->json(['status' => true, 'data' => $children]);
    }

    // GET /api/specialist/children/{childId}
    public function show(Request $request, int $childId)
    {
        $this->authorizeChildAccess($request, $childId);

        $child = Child::select('id', 'name', 'Userid')->findOrFail($childId);

        return response()->json(['status' => true, 'data' => $child]);
    }
}