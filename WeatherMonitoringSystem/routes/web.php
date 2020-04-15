<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Auth Routes
|--------------------------------------------------------------------------
*/


Route::get('/login', 'AuthController@loginView')->name('login');
Route::post('/login', 'AuthController@loginUser');
Route::get('/logout', 'AuthController@logout')->middleware(['auth']);
/*
|--------------------------------------------------------------------------
| Dashboard Routes
|--------------------------------------------------------------------------
*/

Route::middleware(['auth'])->group(function () {


    Route::get('/', 'DashboardController@index');
    Route::post('/add-new-device', 'DashboardController@addNewDevice');
    Route::get('/device/{devices_id}/remove', 'DashboardController@removeDevice');
});
