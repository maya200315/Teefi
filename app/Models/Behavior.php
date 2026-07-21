<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Behavior extends Model
{
    use HasFactory;

    protected $table = 'behaviors';

    protected $fillable = [
        'date',
        'notes',
        'Behavior_typeid',
        'Childid',
        'Userid',
    ];

    protected $casts = [
        'date' => 'date',
    ];

    public function behaviorType(): BelongsTo
    {
        return $this->belongsTo(BehaviorType::class, 'Behavior_typeid');
    }

    public function child(): BelongsTo
    {
        return $this->belongsTo(Child::class, 'Childid');
    }

    // مين سجّل (أهل أو أخصائي - بنفس جدول users)
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }
}
