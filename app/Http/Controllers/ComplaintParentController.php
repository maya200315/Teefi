<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ComplaintParentController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title'   => 'required|string|max:255',
            'message' => 'required|string',
        ]);

        $complaint = Complaint::create([
            'title'   => $validated['title'],
            'message' => $validated['message'],
            'Userid'  => Auth::id(),
        ]);

        return response()->json([
            'message'   => 'تم إرسال الشكوى بنجاح',
            'complaint' => $complaint,
        ], 201);
    }
}