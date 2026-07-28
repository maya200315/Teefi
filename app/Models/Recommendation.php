<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Recommendation extends Model
{
    
    protected $table = 'recommendations';

    protected $fillable = ['text', 'date', 'Userid', 'Childid'];

    protected $casts = ['date' => 'date'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }

    public function child(): BelongsTo
    {
        return $this->belongsTo(Child::class, 'Childid');
    }
}
