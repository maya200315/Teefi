<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\PecsCardChild;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class PecsCardChildController extends Controller
{
    // GET /api/pecs-card-child/{child_id}
    // جلب كل بطاقات PECS المرتبطة بطفل معين
    public function index(int $child_id)
    {
        $records = PecsCardChild::with(['pecsCard.category'])
            ->where('Childid', $child_id)
            ->get();

        if ($records->isEmpty()) {
            return response()->json([
                'status'  => true,
                'message' => 'No PECS cards found for this child',
                'data'    => []
            ], 200);
        }

        // أضف الـ image_url لكل بطاقة
        $records->transform(function ($record) {
            if ($record->pecsCard && $record->pecsCard->image) {
                $record->pecsCard->image_url = asset('storage/' . $record->pecsCard->image);            }
            return $record;
        });

        return response()->json([
            'status' => true,
            'data'   => $records
        ], 200);
    }

    // POST /api/pecs-card-child
    // ربط بطاقة PECS بطفل
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'PECS_cardid' => 'required|exists:pecs_cards,id',
            'Childid'     => 'required|exists:children,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        // تحقق إنو الربط مش موجود مسبقاً
        $exists = PecsCardChild::where('PECS_cardid', $request->PECS_cardid)
            ->where('Childid', $request->Childid)
            ->exists();

        if ($exists) {
            return response()->json([
                'status'  => false,
                'message' => 'This PECS card is already assigned to this child'
            ], 409);
        }

        $record = PecsCardChild::create([
            'PECS_cardid' => $request->PECS_cardid,
            'Childid'     => $request->Childid,
        ]);

        return response()->json([
            'status'  => true,
            'message' => 'PECS Card assigned to child successfully',
            'data'    => $record->load('pecsCard.category')
        ], 201);
    }

    // DELETE /api/pecs-card-child/{id}
    // إلغاء ربط بطاقة من طفل
    public function destroy(int $id)
    {
        $record = PecsCardChild::find($id);

        if (!$record) {
            return response()->json([
                'status'  => false,
                'message' => 'Record not found'
            ], 404);
        }

        $record->delete();

        return response()->json([
            'status'  => true,
            'message' => 'PECS Card unassigned from child successfully'
        ], 200);
    }
}
