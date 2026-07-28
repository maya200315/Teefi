<?php
// app/Models/Specialist.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Specialist extends Model
{
    protected $fillable = [
        'user_id',
        'specialty',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function parentts()
    {
        return $this->hasMany(Parentt::class, 'specialist_id');
    }
}
