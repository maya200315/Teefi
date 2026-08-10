<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * بيسمح بالوصول بس للمستخدم يلي دوره 'specialist' (Roleid = 2).
 */
class EnsureUserIsSpecialist
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();
        
        // تأكد إنو المستخدم موجود ودوره specialist (Roleid = 2)
        abort_unless(
            $user && $user->Roleid === 2,
            403,
            'هاد المسار للأخصائيين بس.'
        );

        return $next($request);
    }
}