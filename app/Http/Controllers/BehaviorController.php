<?php

namespace App\Http\Controllers;

use App\Models\Behavior;
use Illuminate\Http\Request;

class BehaviorController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'Childid'          => 'required|exists:children,id',
            'Behavior_typeid'  => 'required|exists:behavior_types,id',
            'notes'            => 'nullable|string|max:1000',
        ]);

        $behavior = Behavior::create([
            'date'             => now()->toDateString(), // تاريخ اليوم تلقائياً
            'notes'            => $validated['notes'] ?? null,
            'Behavior_typeid'  => $validated['Behavior_typeid'],
            'Childid'          => $validated['Childid'],
            'Userid'           => $request->user()->id, // مين سجّل (أهل أو أخصائي)
        ]);

        return response()->json($behavior->load('behaviorType', 'user'), 201);
    }

    // تقرير: سجلات طفل معيّن مجمّعة حسب نوع السلوك
    public function reportByChild(int $childId)
    {
        return Behavior::where('Childid', $childId)
            ->with('behaviorType', 'user')
            ->orderByDesc('date')
            ->get()
            ->groupBy('behaviorType.name');
    }
}
