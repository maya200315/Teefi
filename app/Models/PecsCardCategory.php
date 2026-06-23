<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PecsCardCategory extends Model
{
    protected $table = 'pecs_card_categories';

    protected $fillable = ['name', 'code'];

    public function pecsCards(): HasMany
    {
        return $this->hasMany(PecsCard::class, 'PECS_card_categoryid');
    }
}
