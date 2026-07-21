<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserHomeController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $parentt = $user->parentt;


        if (!$parentt) {
            return response()->json([
                'message' => 'No data found.'
            ], 404);
        }

        return response()->json([
            'child' => [
                'id'    => $parentt->id,
                'name' => $parentt->name,
                'age'          => $parentt->age,
                'autism_level' => $parentt->autism_level,
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
