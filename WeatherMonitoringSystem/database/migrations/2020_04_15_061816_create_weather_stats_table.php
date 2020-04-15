<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWeatherStatsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('weather_stats', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('device_id');
            $table->string('device_key');
            $table->string('temperature');
            $table->string('pressure');
            $table->string('rain');
            $table->string('humidity');
            $table->string('soil_moisture');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('weather_stats');
    }
}
