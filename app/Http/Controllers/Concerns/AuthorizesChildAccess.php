<?php

namespace App\Http\Controllers\Concerns;

use App\Models\Child;
use App\Models\Parentt;
use App\Models\Specialist;
use Illuminate\Http\Request;

trait AuthorizesChildAccess
{
    protected function authorizeChildAccess(
        Request $request,
        int $childId
    ): Child {
        $user = $request->user();
        $child = Child::findOrFail($childId);

        // Roleid = 2 يعني أخصائي حسب تصميم المشروع
        $isSpecialist = (int) $user->Roleid === 2;

        if ($isSpecialist) {
            $specialist = Specialist::where('user_id', $user->id)->first();

            $hasAccess = $specialist
                && Parentt::where('specialist_id', $specialist->id)
                    ->where('user_id', $child->Userid)
                    ->exists();
        } else {
            // ولي الأمر يستطيع الوصول إلى أطفاله فقط
            $hasAccess = (int) $child->Userid === (int) $user->id;
        }

        abort_unless(
            $hasAccess,
            403,
            'ليس لديك صلاحية للوصول إلى بيانات هذا الطفل.'
        );

        return $child;
    }
}