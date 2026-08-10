<?php

namespace App\Http\Controllers;

use App\Models\Complaint;

class ComplaintController extends Controller
{
    // كل الشكاوي
    public function index()
    {
        $complaints = Complaint::with('user')->latest()->paginate(20);
        return response()->json($complaints);
    }

    // شكوى معيّنة
    public function show($id)
    {
        $complaint = Complaint::with('user')->find($id);

        if (!$complaint) {
            return response()->json(['message' => 'الشكوى غير موجودة'], 404);
        }

        return response()->json($complaint);
    }
}