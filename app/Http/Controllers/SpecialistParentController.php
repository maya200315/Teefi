<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Parentt;
use App\Models\Specialist;
use App\Models\User;
use Illuminate\Http\Request;

class SpecialistParentController extends Controller
{

    // GET /api/admin/specialists
    public function specialists()
    {
        $specialists = User::where('Roleid', 2)
            ->select('id', 'name', 'mobile_number')
            ->get();

        return response()->json(['status' => true, 'data' => $specialists]);
    }

    // GET /api/admin/parents
    public function parents()
    {
        $parents = User::where('Roleid', 3)
            ->select('id', 'name', 'mobile_number')
            ->get();

        return response()->json(['status' => true, 'data' => $parents]);
    }

    // GET /api/admin/specialist-parent-links?specialist_id=&parent_id=
    public function index(Request $request)
    {
        $links = Parentt::query()
            ->with([
                'specialist.user:id,name,mobile_number',
                'user:id,name,mobile_number',
            ])
            ->when($request->query('specialist_id'), fn ($q, $id) => $q->whereHas(
                'specialist', fn ($sq) => $sq->where('user_id', $id)
            ))
            ->when($request->query('parent_id'), fn ($q, $id) => $q->where('user_id', $id))
            ->latest()
            ->get();

        return response()->json(['status' => true, 'data' => $links]);
    }

    // POST /api/admin/specialist-parent-links
    // Body: { "Specialistid": <users.id تبع الأخصائي>, "Parentid": <users.id تبع ولي الأمر> }
    public function store(Request $request)
    {
        $validated = $request->validate([
            'Specialistid' => ['required', 'exists:users,id'],
            'Parentid'     => ['required', 'exists:users,id'],
        ]);

        $specialistUser = User::find($validated['Specialistid']);
        $parentUser     = User::find($validated['Parentid']);

        abort_if($specialistUser->Roleid !== 2, 422, 'الـ Specialistid المُدخل مش تبع أخصائي.');
        abort_if($parentUser->Roleid !== 3, 422, 'الـ Parentid المُدخل مش تبع ولي أمر.');

        $specialist = Specialist::where('user_id', $specialistUser->id)->firstOrFail();

        // parentts.user_id لازم يكون فريد (كل ولي أمر بسجل وحدة بس؟)
        // إذا ولي الأمر ممكن يكون مرتبط بأكتر من أخصائي، لازم تتأكد إنو
        // بنية جدول parentts بتسمح بهيك (unique على user_id لحالو بيمنع هيك)
        $link = Parentt::firstOrCreate(
            ['user_id' => $validated['Parentid']],
            ['specialist_id' => $specialist->id]
        );

        // إذا السجل موجود مسبقاً بس مرتبط بأخصائي تاني، حدّثه:
        if ($link->specialist_id !== $specialist->id) {
            $link->update(['specialist_id' => $specialist->id]);
        }

        return response()->json(['status' => true, 'data' => $link], 201);
    }

    // DELETE /api/admin/specialist-parent-links/{id}
    public function destroy(int $id)
    {
        Parentt::findOrFail($id)->delete();

        return response()->json(['status' => true, 'message' => 'تم فك الربط بنجاح.']);
    }
}
