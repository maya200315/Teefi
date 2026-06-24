<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class ManageUsersController extends Controller
{
    // Role IDs (must match your roles table)
    private const ROLE_SPECIALIST = 2;
    private const ROLE_PARENT     = 3;

    // -------------------------------------------------------------------------
    // Helper: resolve role id from type string
    // -------------------------------------------------------------------------
    private function roleId(string $type): int
    {
        return $type === 'specialists' ? self::ROLE_SPECIALIST : self::ROLE_PARENT;
    }

    // -------------------------------------------------------------------------
    // GET /api/admin/users/{type}
    // type = "parents" | "specialists"
    // Returns list + total count
    // -------------------------------------------------------------------------
    public function index(string $type): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type. Use "parents" or "specialists".'], 422);
        }

        $users = User::where('Roleid', $this->roleId($type))
            ->select('id', 'name', 'mobile_number', 'created_at')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'type'    => $type,
            'count'   => $users->count(),
            'data'    => $users,
        ]);
    }

    // -------------------------------------------------------------------------
    // GET /api/admin/users/{type}/{id}
    // Show a single user
    // -------------------------------------------------------------------------
    public function show(string $type, int $id): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        $user = User::where('Roleid', $this->roleId($type))->find($id);

        if (!$user) {
            return response()->json(['success' => false, 'message' => 'User not found.'], 404);
        }

        return response()->json([
            'success' => true,
            'data'    => $user->only('id', 'name', 'mobile_number', 'created_at'),
        ]);
    }

    // -------------------------------------------------------------------------
    // POST /api/admin/users/{type}
    // Create a new parent or specialist
    // -------------------------------------------------------------------------
    public function store(Request $request, string $type): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        try {
            $validated = $request->validate([
                'name'          => 'required|string|max:255',
                'mobile_number' => 'required|string|unique:users,mobile_number|max:20',
                'password'      => 'required|string|min:6',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);
        }

        $user = User::create([
            'name'          => $validated['name'],
            'mobile_number' => $validated['mobile_number'],
            'password'      => Hash::make($validated['password']),
            'Roleid'        => $this->roleId($type),
        ]);

        return response()->json([
            'success' => true,
            'message' => ucfirst(rtrim($type, 's')) . ' created successfully.',
            'data'    => $user->only('id', 'name', 'mobile_number', 'created_at'),
        ], 201);
    }

    // -------------------------------------------------------------------------
    // PUT /api/admin/users/{type}/{id}
    // Update a parent or specialist
    // -------------------------------------------------------------------------
    public function update(Request $request, string $type, int $id): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        $user = User::where('Roleid', $this->roleId($type))->find($id);

        if (!$user) {
            return response()->json(['success' => false, 'message' => 'User not found.'], 404);
        }

        try {
            $validated = $request->validate([
                'name'          => 'sometimes|required|string|max:255',
                'mobile_number' => 'sometimes|required|string|max:20|unique:users,mobile_number,' . $id,
                'password'      => 'sometimes|nullable|string|min:6',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);
        }

        if (isset($validated['name']))          $user->name          = $validated['name'];
        if (isset($validated['mobile_number'])) $user->mobile_number = $validated['mobile_number'];
        if (!empty($validated['password']))     $user->password      = Hash::make($validated['password']);

        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'User updated successfully.',
            'data'    => $user->only('id', 'name', 'mobile_number', 'created_at'),
        ]);
    }

    // -------------------------------------------------------------------------
    // DELETE /api/admin/users/{type}/{id}
    // Delete a parent or specialist
    // -------------------------------------------------------------------------
    public function destroy(string $type, int $id): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        $user = User::where('Roleid', $this->roleId($type))->find($id);

        if (!$user) {
            return response()->json(['success' => false, 'message' => 'User not found.'], 404);
        }

        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'User deleted successfully.',
        ]);
    }
}