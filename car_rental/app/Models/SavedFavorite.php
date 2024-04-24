<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SavedFavorite extends Model
{
    use HasFactory;
    protected $table = 'saved_favorite';
    protected $fillable = [
        'vehicle_id','user_id'
    ];
}
