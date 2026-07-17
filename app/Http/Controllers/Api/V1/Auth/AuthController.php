<?php

namespace App\Http\Controllers\Api\V1\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\V1\Auth\LoginRequest;
use App\Http\Requests\Api\V1\Auth\RegisterRequest;
use App\Http\Resources\V1\UserResource;
use App\Services\AuthService;
use App\Traits\ApiResponse;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    use ApiResponse;

    protected AuthService $authService;

    public function __construct(AuthService $authService)
    {
        $this->authService = $authService;
    }

    public function register(RegisterRequest $request): JsonResponse
    {
        try {
            $result = $this->authService->register($request->validated());

            return $this->successResponse([
                'user'         => new UserResource($result['user']),
                'access_token' => $result['token'],
                'token_type'   => 'Bearer'
            ], 'User registered successfully.', 201);
        } catch (Exception $e) {
            return $this->errorResponse('Registration failed.', 500, $e->getMessage());
        }
    }

    public function login(LoginRequest $request): JsonResponse
    {
        try {
            $result = $this->authService->login($request->validated());

            return $this->successResponse([
                'user'         => new UserResource($result['user']),
                'access_token' => $result['token'],
                'token_type'   => 'Bearer'
            ], 'Logged in successfully.', 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return $this->errorResponse('Validation Error', 422, $e->errors());
        } catch (Exception $e) {
            return $this->errorResponse('Login failed.', 500, $e->getMessage());
        }
    }

    public function me(Request $request): JsonResponse
    {
        try {
            return $this->successResponse(
                new UserResource($request->user()),
                'Profile fetched successfully.',
                200
            );
        } catch (Exception $e) {
            return $this->errorResponse('Failed to fetch profile.', 500, $e->getMessage());
        }
    }

    public function logout(Request $request): JsonResponse
    {
        try {
            $request->user()->currentAccessToken()->delete();
            return $this->successResponse(null, 'Logged out successfully, token revoked.', 200);
        } catch (Exception $e) {
            return $this->errorResponse('Logout failed.', 500, $e->getMessage());
        }
    }
}
