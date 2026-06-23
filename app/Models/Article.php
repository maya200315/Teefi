<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Article extends Model
{
    protected $table = 'articles';

    protected $fillable = ['title', 'content', 'date', 'Userid'];

    protected $casts = ['date' => 'date'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }
}
