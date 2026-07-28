<?php

namespace App\Models;

use Laravel\Sanctum\HasApiTokens;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class User extends Authenticatable
{
    use HasApiTokens;

    protected $fillable = [
        'password',
        'name',
        'mobile_number',
        'Roleid',
    ];

    protected $hidden = ['password'];

    public function role(): BelongsTo
    {
        return $this->belongsTo(Role::class, 'Roleid');
    }

    public function children(): HasMany
    {
        return $this->hasMany(Child::class, 'Userid');
    }

    public function userTokens(): HasMany
    {
        return $this->hasMany(UserToken::class, 'Userid');
    }

    public function behaviorTypes(): HasMany
    {
        return $this->hasMany(BehaviorType::class, 'Userid');
    }

    public function dailyNotes(): HasMany
    {
        return $this->hasMany(DailyNote::class, 'Userid');
    }

    public function weeklyReports(): HasMany
    {
        return $this->hasMany(WeeklyReport::class, 'Userid');
    }

    public function recommendations(): HasMany
    {
        return $this->hasMany(Recommendation::class, 'Userid');
    }

    public function articles(): HasMany
    {
        return $this->hasMany(Article::class, 'Userid');
    }
    public function specialist()
    {
        return $this->hasOne(Specialist::class);
    }
    public function parentt()
    {
        return $this->hasOne(Parentt::class, 'user_id', 'id');
    }
}
