<?php

namespace App\Http\Controllers;

use App\Models\PecsCardCategory;
use Illuminate\Http\Request;

class PecsCardParentController extends Controller
{
    

    /**
     * كل الكاتيغوريز - لما يضغط الأهل عزر Pecs بالهوم
     */
    public function indexForParents()
    {
        $categories = PecsCardCategory::orderBy('name')
            ->get(['id', 'name', 'image']); // بس الحقول يلي بدها ياها الأهل

        $categories->transform(function ($category) {
            return [
                'id'    => $category->id,
                'name'  => $category->name,
                'image' => $category->image ? asset('storage/' . $category->image) : null,
            ];
        });

        return response()->json([
            'status' => true,
            'data'   => $categories
        ], 200);
    }

    /**
     * كل الكروت تبع كاتيغوري محددة - لما يضغط الأهل ع كاتيغوري
     */
    public function cardsForParents(int $id)
    {
        $category = PecsCardCategory::find($id, ['id', 'name']);

        if (!$category) {
            return response()->json([
                'status'  => false,
                'message' => 'Category not found'
            ], 404);
        }

        $cards = $category->cards()
            ->orderBy('created_at', 'desc')
            ->get(['id', 'title', 'image', 'PECS_card_categoryid']);

        $cards->transform(function ($card) {
            return [
                'id'    => $card->id,
                'title' => $card->title,
                'image' => $card->image ? asset('storage/' . $card->image) : null,
            ];
        });

        return response()->json([
            'status'   => true,
            'category' => [
                'id'   => $category->id,
                'name' => $category->name,
            ],
            'data'     => $cards
        ], 200);
    }

}
