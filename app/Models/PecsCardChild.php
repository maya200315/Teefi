<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PecsCardChild extends Model
{
    
    protected $table = 'pecs_card_child'; // ← هاد الإضافة المهمة

    protected $fillable = ['PECS_cardid', 'Childid'];

    public function pecsCard()
    {
        return $this->belongsTo(PecsCard::class, 'PECS_cardid');
    }

    public function child()
    {
        return $this->belongsTo(Child::class, 'Childid');
    }
}
