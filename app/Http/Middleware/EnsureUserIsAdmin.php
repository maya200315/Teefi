<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * بيسمح بالوصول بس للمستخدم يلي دوره 'admin' (Roleid = 1).
 */
class EnsureUserIsAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();
        
        // تأكد إنو المستخدم موجود ودوره admin (Roleid = 1)
        abort_unless(
            $user && $user->Roleid === 1,
            403,
            'هاد المسار للأدمن بس.'
        );

        return $next($request);
    }
}