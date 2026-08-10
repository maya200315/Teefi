<?php

// namespace App\Http\Controllers\Concerns;

// use App\Models\Child;
// use Illuminate\Http\Request;

// trait AuthorizesChildAccess
// {
//     protected function authorizeChildAccess(
//         Request $request,
//         int $childId
//     ): Child {
//         $user = $request->user();

//         $child = Child::findOrFail($childId);

//         // Roleid = 2 حسب تصميم المشروع
//         $isSpecialist = (int) $user->Roleid === 2;

//         if ($isSpecialist) {
//             $hasAccess = $user->parents()
//                 ->where('users.id', $child->Userid)
//                 ->exists();
//         } else {
//             // ولي الأمر يجب أن يكون مالك الطفل مباشرة
//             $hasAccess = (int) $child->Userid === (int) $user->id;
//         }

//         abort_unless(
//             $hasAccess,
//             403,
//             'ليس لديك صلاحية للوصول إلى بيانات هذا الطفل.'
//         );

//         return $child;
//     }
// }