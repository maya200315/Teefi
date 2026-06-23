<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Article extends Model
{
    protected $table = 'articles';

    protected $fillable = ['title', 'content', 'datetime', 'Userid'];

    protected $casts = ['datetime' => 'datetime'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }
}
