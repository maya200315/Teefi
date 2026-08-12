<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * بيسمح بالوصول بس للمستخدم يلي دوره 'parent' (Roleid = 3).
 */
class EnsureUserIsParent
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        abort_unless(
            $user && (int) $user->Roleid === 3,
            403,
            'هاد المسار للأبوين بس.'
        );

        return $next($request);
    }
}