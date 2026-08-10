<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SpecialistParent extends Model
{
    protected $table = 'specialist_parent';

    protected $fillable = ['Specialistid', 'Parentid'];

    public function specialist()
    {
        return $this->belongsTo(User::class, 'Specialistid');
    }

    public function parent()
    {
        return $this->belongsTo(User::class, 'Parentid');
    }
}
