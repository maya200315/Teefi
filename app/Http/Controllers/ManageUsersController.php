<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Specialist;
use App\Models\Parentt;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class ManageUsersController extends Controller
{
    private const ROLE_SPECIALIST = 2;
    private const ROLE_PARENT     = 3;

    private function roleId(string $type): int
    {
        return $type === 'specialists' ? self::ROLE_SPECIALIST : self::ROLE_PARENT;
    }

    public function index(string $type): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        $users = User::where('Roleid', $this->roleId($type))
            ->when($type === 'specialists', fn($q) => $q->with('specialist'))
            ->when($type === 'parents', fn($q) => $q->with('parentt.specialist.user'))
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'type'    => $type,
            'count'   => $users->count(),
            'data'    => $users,
        ]);
    }

    public function show(string $type, int $id): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        $user = User::where('Roleid', $this->roleId($type))
            ->when($type === 'specialists', fn($q) => $q->with('specialist'))
            ->when($type === 'parents', fn($q) => $q->with('parentt.specialist.user'))
            ->find($id);

        if (!$user) {
            return response()->json(['success' => false, 'message' => 'User not found.'], 404);
        }

        return response()->json(['success' => true, 'data' => $user]);
    }

    public function store(Request $request, string $type): JsonResponse
    {
        if (!in_array($type, ['parents', 'specialists'])) {
            return response()->json(['success' => false, 'message' => 'Invalid user type.'], 422);
        }

        try {
            $rules = [
                'name'          => 'required|string|max:255',
                'mobile_number' => 'required|string|unique:users,mobile_number|max:20',
                'password'      => 'required|string|min:6',
            ];

            if ($type === 'specialists') {
                $rules['specialty'] = 'required|string|in:Speech Therapy,Behavior Therapy,Occupational Therapy,Psychologist';
            }

            if ($type === 'parents') {
                $rules['autism_level']  = 'required|in:mild,medium,severe';
                $rules['specialist_id'] = 'required|exists:specialists,id';
            }

            $validated = $request->validate($rules);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);
        }

        DB::beginTransaction();
        try {
            $user = User::create([
                'name'          => $validated['name'],
                'mobile_number' => $validated['mobile_number'],
                'password'      => Hash::make($validated['password']),
                'Roleid'        => $this->roleId($type),
            ]);

            if ($type === 'specialists') {
                Specialist::create([
                    'user_id'   => $user->id,
                    'specialty' => $validated['specialty'],
                ]);
            }

            if ($type === 'parents') {
                Parentt::create([
                    'user_id'       => $user->id,
                    'autism_level'  => $validated['autism_level'],
                    'specialist_id' => $validated['specialist_id'],
                ]);
            }

            DB::commit();

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['success' => false, 'message' => 'Something went wrong.', 'error' => $e->getMessage()], 500);
        }

        $user->load($type === 'specialists' ? 'specialist' : 'parentt.specialist.user');

        return response()->json([
            'success' => true,
            'message' => ucfirst(rtrim($type, 's')) . ' created successfully.',
            'data'    => $user,
        ], 201);
    }

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
            $rules = [
                'name'          => 'sometimes|required|string|max:255',
                'mobile_number' => 'sometimes|required|string|max:20|unique:users,mobile_number,' . $id,
                'password'      => 'sometimes|nullable|string|min:6',
            ];

            if ($type === 'specialists') {
                $rules['specialty'] = 'sometimes|required|string|in:Speech Therapy,Behavior Therapy,Occupational Therapy,Psychologist';
            }

            if ($type === 'parents') {
                $rules['autism_level']  = 'sometimes|required|in:mild,medium,severe';
                $rules['specialist_id'] = 'sometimes|required|exists:specialists,id';
            }

            $validated = $request->validate($rules);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);
        }

        DB::beginTransaction();
        try {
            if (isset($validated['name']))          $user->name          = $validated['name'];
            if (isset($validated['mobile_number'])) $user->mobile_number = $validated['mobile_number'];
            if (!empty($validated['password']))     $user->password      = Hash::make($validated['password']);
            $user->save();

            if ($type === 'specialists' && isset($validated['specialty'])) {
                $user->specialist()->update(['specialty' => $validated['specialty']]);
            }

            if ($type === 'parents') {
                $data = [];
                if (isset($validated['autism_level']))  $data['autism_level']  = $validated['autism_level'];
                if (isset($validated['specialist_id'])) $data['specialist_id'] = $validated['specialist_id'];
                if ($data) $user->parentt()->update($data);
            }

            DB::commit();

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['success' => false, 'message' => 'Something went wrong.'], 500);
        }

        $user->load($type === 'specialists' ? 'specialist' : 'parentt.specialist.user');

        return response()->json([
            'success' => true,
            'message' => 'User updated successfully.',
            'data'    => $user,
        ]);
    }

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

        return response()->json(['success' => true, 'message' => 'User deleted successfully.']);
    }
}