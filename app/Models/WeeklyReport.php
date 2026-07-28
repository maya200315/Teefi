<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class WeeklyReport extends Model
{
    
    protected $table = 'weekly_reports';

    protected $fillable = [
        'week_start',
        'week_end',
        'total_behaviors',
        'positive_count',
        'negative_count',
        'summary',
        'Childid',
        'Userid',
    ];

    protected $casts = [
        'week_start' => 'date',
        'week_end'   => 'date',
    ];

    public function child(): BelongsTo
    {
        return $this->belongsTo(Child::class, 'Childid');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }
}
