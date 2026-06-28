<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Parentt extends Model
{
    protected $table = 'parentts';

    protected $fillable = [
        'user_id',
        'autism_level',
        'specialist_id',
        'age',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function specialist()
    {
        return $this->belongsTo(Specialist::class);
    }
}
