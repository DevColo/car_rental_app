<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VehicleBooking extends Model
{
    use HasFactory;
    protected $table = 'vehicle_booking';
    protected $fillable = [
        'start_date','start_time','end_date','end_time','vehicle_id','user_id','status'
    ];
}
