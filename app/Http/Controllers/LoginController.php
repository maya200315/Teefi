<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $data = $request->validate([
            'mobile_number' => ['required', 'string'],
            'password' => ['required', 'string'],
        ]);

        $user = User::where('mobile_number', $data['mobile_number'])->first();

        if (!$user || !Hash::check($data['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid mobile number or password'
            ], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Login successful',
            'user' => $user->only(['id', 'mobile_number']),
            'token' => $token,
            'token_type' => 'Bearer',
        ], 200);
    }
}
