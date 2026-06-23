<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class PecsCard extends Model
{
    protected $table = 'pecs_cards';

    protected $fillable = ['title', 'image', 'PECS_card_categoryid'];

    public function category(): BelongsTo
    {
        return $this->belongsTo(PecsCardCategory::class, 'PECS_card_categoryid');
    }

    public function children(): BelongsToMany
    {
        return $this->belongsToMany(Child::class, 'pecs_card_child', 'PECS_cardid', 'Childid');
    }
}
