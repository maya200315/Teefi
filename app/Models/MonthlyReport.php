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
        'parent_note',
        'specialist_recommendation',
        'recommendation_by',
        'recommendation_at',
    ];

    protected $casts = [
        'month_start' => 'date',
        'month_end'   => 'date',
        'recommendation_at'  => 'datetime',

    ];

    public function child(): BelongsTo
    {
        return $this->belongsTo(Child::class, 'Childid');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'Userid');
    }

    public function recommendedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'recommendation_by');
    }
}
