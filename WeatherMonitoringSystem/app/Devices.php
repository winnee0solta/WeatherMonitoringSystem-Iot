<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Devices extends Model
{
    protected $fillable = [
        'location',
        'device_key',
    ];
}
