<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\AuthorizesChildAccess;
use App\Models\Recommendation;
use Illuminate\Http\Request;

class RecommendationController extends Controller
{
use AuthorizesChildAccess;

    // GET /api/children/{childId}/recommendations
    // بيرجع كل توصيات الأخصائي لطفل معيّن، الأحدث أولاً
    public function index(Request $request, int $childId)
    {
        $this->authorizeChildAccess($request, $childId);

        $recommendations = Recommendation::where('Childid', $childId)
            ->with('user:id,name') // عدّل الأعمدة حسب جدول users عندك
            ->orderByDesc('date')
            ->orderByDesc('id')
            ->get();

        return response()->json(['status' => true, 'data' => $recommendations]);
    }

    // POST /api/children/{childId}/recommendations
    public function store(Request $request, int $childId)
    {
        $this->authorizeChildAccess($request, $childId);

        $validated = $request->validate([
            'text' => ['required', 'string', 'max:255'],
            'date' => ['nullable', 'date'],
        ]);

        $recommendation = Recommendation::create([
            'text'    => $validated['text'],
            'date'    => $validated['date'] ?? now()->toDateString(),
            'Childid' => $childId,
            'Userid'  => $request->user()->id,
        ]);

        return response()->json(['status' => true, 'data' => $recommendation], 201);
    }

    // PUT /api/recommendations/{id}
    public function update(Request $request, int $id)
    {
        $recommendation = Recommendation::findOrFail($id);
        $this->authorizeChildAccess($request, $recommendation->Childid);

        $validated = $request->validate([
            'text' => ['sometimes', 'required', 'string', 'max:255'],
            'date' => ['sometimes', 'nullable', 'date'],
        ]);

        $recommendation->update($validated);

        return response()->json(['status' => true, 'data' => $recommendation]);
    }

    // DELETE /api/recommendations/{id}
    public function destroy(Request $request, int $id)
    {
        $recommendation = Recommendation::findOrFail($id);
        $this->authorizeChildAccess($request, $recommendation->Childid);

        $recommendation->delete();

        return response()->json(['status' => true, 'message' => 'تم حذف التوصية بنجاح.']);
    }
}
