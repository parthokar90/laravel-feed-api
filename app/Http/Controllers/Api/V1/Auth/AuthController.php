<?php

namespace App\Http\Controllers\Api\V1\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Http\Requests\Api\V1\Auth\RegisterRequest;
use App\Http\Requests\Api\V1\Auth\LoginRequest;

use App\Services\V1\AuthService;
use App\Http\Resources\Api\V1\UserResource;

use Exception;

use Illuminate\Support\Facades\Log;

use Illuminate\Http\JsonResponse;

use Illuminate\Support\Facades\Cookie;

class AuthController extends Controller
{
    public function __construct(private AuthService $authService) {}

    public function register(RegisterRequest $request): JsonResponse
    {
        try {
            $user = $this->authService->register($request->validated());

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'success' => true,
                'message' => 'Registration successful',
                'data'    => new UserResource($user),
            ], 201)->cookie(
                'token',
                $token,
                60 * 24 * 7,
                '/',
                null,
                true,
                true,
                false,
                'Strict'
            );
        } catch (Exception $e) {
            Log::error('User registration failed', [
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);
            return response()->json([
                'message' => 'Registration failed',
            ], 500);
        }
    }

    public function login(LoginRequest $request): JsonResponse
    {
        try {
            $result = $this->authService->login($request->validated());

            if (!$result) {
                return response()->json([
                    'message' => 'Invalid credentials'
                ], 401);
            }

            return response()->json([
                'success' => true,
                'message' => 'Login successful',
                'data' => new UserResource($result['user']),
            ], 200)->cookie(
                env('AUTH_COOKIE_NAME', 'token'),
                $result['token'],
                env('AUTH_COOKIE_MINUTES', 60 * 24 * 7),
                env('AUTH_COOKIE_PATH', '/'),
                null,
                filter_var(env('AUTH_COOKIE_SECURE', false), FILTER_VALIDATE_BOOLEAN),
                true,
                false,
                env('AUTH_COOKIE_SAMESITE', 'Lax')
            );
        } catch (Exception $e) {
            Log::error('login failed', [
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);
            return response()->json([
                'message' => 'Login failed',
            ], 500);
        }
    }

    public function me(Request $request): JsonResponse
    {
        try {
            return response()->json([
                'success' => true,
                'message' => 'User fetched successfully',
                'data'    => new UserResource($request->user()),
            ], 200);
        } catch (\Exception $e) {

            Log::error('ME API failed', [
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch user',
            ], 500);
        }
    }

    public function logout(Request $request): JsonResponse
    {
        try {
            $request->user()->currentAccessToken()->delete();

            return response()->json([
                'success' => true,
                'message' => 'Logged out successfully',
            ])->withCookie(
                Cookie::forget(env('AUTH_COOKIE_NAME', 'token'), env('AUTH_COOKIE_PATH', '/'))
            );
        } catch (Exception $e) {
            Log::error('User logout failed', [
                'message' => $e->getMessage(),
                'file'    => $e->getFile(),
                'line'    => $e->getLine(),
            ]);
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong during logout',
            ], 500);
        }
    }
}
