<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MonthlyReport extends Model
{
    protected $table = 'monthly_reports';

    protected $fillable = [
        'month_start',
        'month_end',
        'total_behaviors',
        'positive_count',
        'negative_count',
        'summary',
        'Childid',
        'Userid',
    ];

    protected $casts = [
        'month_start' => 'date',
        'month_end'   => 'date',
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
