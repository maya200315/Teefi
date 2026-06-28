<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\PecsCardCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PecsCardCategoryController extends Controller
{
    public function index()
    {
        $categories = PecsCardCategory::withCount('pecsCards')
            ->orderBy('id')
            ->get();

        return response()->json([
            'status' => true,
            'data'   => $categories
        ], 200);
    }

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
public function store(Request $request)
{
    $validator = Validator::make($request->all(), [
        'name'  => 'required|string|max:255',
        'image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => false,
            'errors' => $validator->errors()
        ], 422);
    }

    $imagePath = null;
    if ($request->hasFile('image')) {
        $imagePath = $request->file('image')->store('pecs_categories', 'public');
    }

    $category = PecsCardCategory::create([
        'name'  => $request->name,
        'image' => $imagePath,
    ]);

    return response()->json([
        'status'  => true,
        'message' => 'PECS Card created successfully',
        'data'    => $category
    ], 201);
}public function update(Request $request, int $id)
{
    $category = PecsCardCategory::find($id);

    if (!$category) {
        return response()->json([
            'status'  => false,
            'message' => 'Category not found'
        ], 404);
    }

    $validator = Validator::make($request->all(), [
        'name'  => 'sometimes|string|max:255',
        'image' => 'sometimes|nullable|image|mimes:jpeg,png,jpg|max:2048',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => false,
            'errors' => $validator->errors()
        ], 422);
    }

    if ($request->hasFile('image')) {
        $imagePath = $request->file('image')->store('pecs_categories', 'public');
        $category->image = $imagePath;
    }

    if ($request->has('name')) {
        $category->name = $request->name;
    }

    $category->save();

    return response()->json([
        'status'  => true,
        'message' => 'Category updated successfully',
        'data'    => $category
    ], 200);
}
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
