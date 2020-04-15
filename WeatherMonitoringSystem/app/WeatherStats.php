<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class WeatherStats extends Model
{
    protected $fillable = [
        'device_id',
        'device_key',
        'temperature',
        'pressure',
        'rain',
        'humidity',
        'soil_moisture',
    ];
}
