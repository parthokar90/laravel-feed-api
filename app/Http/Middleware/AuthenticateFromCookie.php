<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AuthenticateFromCookie
{
    // AuthenticateFromCookie.php তে temporarily add করো

    public function handle(Request $request, Closure $next)
    {
        $token = $request->cookie(env('AUTH_COOKIE_NAME', 'token'));

        \Log::info('Cookie debug', [
            'all_cookies' => $request->cookies->all(),
            'token'       => $token,
            'bearer'      => $request->bearerToken(),
        ]);

        if ($token && !$request->bearerToken()) {
            $request->headers->set('Authorization', 'Bearer ' . $token);
        }

        return $next($request);
    }
}
