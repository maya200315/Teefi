<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Behavior extends Model
{
    protected $table = 'behaviors';

    protected $fillable = [
        'date',
        'notes',
        'datetime',
        // 'Behavior_typeid',
        'Childid',
    ];

    protected $casts = [
        'date'     => 'date',
        'datetime' => 'date',
    ];

    public function behaviorType(): BelongsTo
    {
        return $this->belongsTo(BehaviorType::class, 'Behavior_typeid');
    }

    public function child(): BelongsTo
    {
        return $this->belongsTo(Child::class, 'Childid');
    }
}
