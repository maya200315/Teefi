<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * بيسمح بالوصول بس للمستخدم يلي دوره 'super_admin' (Roleid = 4).
 */
class EnsureUserIsSuperAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        abort_unless(
            $user && (int) $user->Roleid === 4,
            403,
            'هاد المسار للمدير العام بس.'
        );

        return $next($request);
    }
}