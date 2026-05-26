<?php

namespace App\Services\V1;

use App\Models\User;
use Illuminate\Support\Facades\Hash;


class AuthService
{
    public function register(array $data): User
    {
        return User::create([
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'],
            'email'       => $data['email'],
            'password'    => Hash::make($data['password']),
        ]);
    }

    public function login(array $data): ?array
    {
        $user = User::where('email', $data['email'])->first();

        if (!$user || !Hash::check($data['password'], $user->password)) {
            return null;
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return [
            'user'  => $user,
            'token' => $token,
        ];
    }
}
