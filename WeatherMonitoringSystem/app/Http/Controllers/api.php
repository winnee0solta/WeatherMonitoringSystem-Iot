<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
*/

//Create Initial Admin Account
Route::get('/a5847fw5as/new-admin/{username}/{password}', 'AuthController@createAdmin');


/*
|--------------------------------------------------------------------------
| For Hardware Routes
|--------------------------------------------------------------------------
|
*/


Route::post('/update-stats', 'ApiController@updateStats');
Route::post('/weather-stats', 'ApiController@weatherStat');
Route::get('/locations', 'ApiController@deviceLocations');
