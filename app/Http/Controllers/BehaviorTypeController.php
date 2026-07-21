<?php

namespace App\Http\Controllers;

use App\Models\BehaviorType;
use Illuminate\Http\Request;

class BehaviorTypeController extends Controller
{
    public function index()
    {
        return BehaviorType::select('id', 'name')->get();
 
    }
}
