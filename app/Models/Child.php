<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Child extends Model
{
    protected $table = 'children';

    protected $fillable = ['name', 'age', 'autism_level', 'Userid'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }

    public function behaviors(): HasMany
    {
        return $this->hasMany(Behavior::class, 'Childid');
    }

    public function dailyNotes(): HasMany
    {
        return $this->hasMany(DailyNote::class, 'Childid');
    }

    public function weeklyReports(): HasMany
    {
        return $this->hasMany(WeeklyReport::class, 'Childid');
    }

    public function recommendations(): HasMany
    {
        return $this->hasMany(Recommendation::class, 'Childid');
    }

    public function pecsCards(): BelongsToMany
    {
        return $this->belongsToMany(PecsCard::class, 'pecs_card_child', 'Childid', 'PECS_cardid');
    }
}
