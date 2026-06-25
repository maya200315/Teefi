<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\PecsCard;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class PecsCardController extends Controller
{

    // public function index(Request $request)
    // {
    //     $query = PecsCard::with('category');

    //     if ($request->has('category_id')) {
    //         $query->where('PECS_card_categoryid', $request->category_id);
    //     }

    //     $cards = $query->orderBy('created_at', 'desc')->get();

    //     $cards->transform(function ($card) {
    //         $card->image_url = $card->image
    //             ? asset('storage/' . $card->image)
    //             : null;
    //         return $card;
    //     });

    //     return response()->json([
    //         'status' => true,
    //         'data'   => $cards
    //     ], 200);
    // }

    public function show(int $id)
    {
        $card = PecsCard::with('category')->find($id);

        if (!$card) {
            return response()->json([
                'status'  => false,
                'message' => 'PECS Card not found'
            ], 404);
        }

        $card->image_url = $card->image
            ? asset('storage/' . $card->image)
            : null;

        return response()->json([
            'status' => true,
            'data'   => $card
        ], 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title'                 => 'required|string|max:255',
            'image'                 => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
            'PECS_card_categoryid'  => 'required|exists:pecs_card_categories,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $imagePath = $request->file('image')->store('pecs_cards', 'public');

        $card = PecsCard::create([
            'title'                => $request->title,
            'image'                => $imagePath,
            'PECS_card_categoryid' => $request->PECS_card_categoryid,
        ]);

        $card->image_url = asset('storage/' . $imagePath);

        return response()->json([
            'status'  => true,
            'message' => 'PECS Card created successfully',
            'data'    => $card
        ], 201);
    }

    public function update(Request $request, int $id)
    {
        $card = PecsCard::find($id);

        if (!$card) {
            return response()->json([
                'status'  => false,
                'message' => 'PECS Card not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'title'                => 'sometimes|string|max:255',
            'image'                => 'sometimes|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
            'PECS_card_categoryid' => 'sometimes|exists:pecs_card_categories,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        if ($request->hasFile('image')) {
            if ($card->image) {
                Storage::disk('public')->delete($card->image);
            }
            $card->image = $request->file('image')->store('pecs_cards', 'public');
        }

        if ($request->has('title')) {
            $card->title = $request->title;
        }

        if ($request->has('PECS_card_categoryid')) {
            $card->PECS_card_categoryid = $request->PECS_card_categoryid;
        }

        $card->save();

        $card->image_url = $card->image
            ? asset('storage/' . $card->image)
            : null;

        return response()->json([
            'status'  => true,
            'message' => 'PECS Card updated successfully',
            'data'    => $card
        ], 200);
    }

    public function destroy(int $id)
    {
        $card = PecsCard::find($id);

        if (!$card) {
            return response()->json([
                'status'  => false,
                'message' => 'PECS Card not found'
            ], 404);
        }

        if ($card->image) {
            Storage::disk('public')->delete($card->image);
        }

        $card->delete();

        return response()->json([
            'status'  => true,
            'message' => 'PECS Card deleted successfully'
        ], 200);
    }
}