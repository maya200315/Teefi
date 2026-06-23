<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BehaviorType extends Model
{
    protected $table = 'behavior_types';

    protected $fillable = ['name', 'Userid'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }

    public function behaviors(): HasMany
    {
        return $this->hasMany(Behavior::class, 'Behavior_typeid');
    }
}
