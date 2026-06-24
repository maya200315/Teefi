<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PecsCardCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PecsCardCategoryController extends Controller
{
    // GET /api/pecs-card-categories
    public function index()
    {
        $categories = PecsCardCategory::withCount('pecsCards')
            ->orderBy('code')
            ->get();

        return response()->json([
            'status' => true,
            'data'   => $categories
        ], 200);
    }

    // GET /api/pecs-card-categories/{id}
    public function show(int $id)
    {
        $category = PecsCardCategory::with('pecsCards')->find($id);

        if (!$category) {
            return response()->json([
                'status'  => false,
                'message' => 'Category not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data'   => $category
        ], 200);
    }

    // POST /api/pecs-card-categories
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'code' => 'required|integer|unique:pecs_card_categories,code',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $category = PecsCardCategory::create([
            'name' => $request->name,
            'code' => $request->code,
        ]);

        return response()->json([
            'status'  => true,
            'message' => 'Category created successfully',
            'data'    => $category
        ], 201);
    }

    // PUT /api/pecs-card-categories/{id}
    public function update(Request $request, int $id)
    {
        $category = PecsCardCategory::find($id);

        if (!$category) {
            return response()->json([
                'status'  => false,
                'message' => 'Category not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|string|max:255',
            'code' => 'sometimes|integer|unique:pecs_card_categories,code,' . $id,
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $category->update($request->only(['name', 'code']));

        return response()->json([
            'status'  => true,
            'message' => 'Category updated successfully',
            'data'    => $category
        ], 200);
    }

    // DELETE /api/pecs-card-categories/{id}
    public function destroy(int $id)
    {
        $category = PecsCardCategory::find($id);

        if (!$category) {
            return response()->json([
                'status'  => false,
                'message' => 'Category not found'
            ], 404);
        }

        $category->delete();

        return response()->json([
            'status'  => true,
            'message' => 'Category deleted successfully'
        ], 200);
    }
}
