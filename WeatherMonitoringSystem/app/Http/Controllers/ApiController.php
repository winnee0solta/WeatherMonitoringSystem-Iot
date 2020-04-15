<?php

namespace App\Http\Controllers;

use App\Devices;
use App\WeatherStats;
use Illuminate\Http\Request;

class ApiController extends Controller
{
    /**
     * Updates Weather Stats for a device/HARDWARE through
     */
    public function updateStats(Request $request)
    {
        $this->validate($request, [
            'device_key' => 'required',
            'temperature' => 'required',
            'pressure' => 'required',
            'rain' => 'required',
            'humidity' => 'required',
            'soil_moisture' => 'required',
        ]);


        //check if key exists
        $stat = WeatherStats::where('device_key', $request->device_key)->first();
        if ($stat) {

            $stat->temperature = $request->temperature;
            $stat->pressure = $request->pressure;
            $stat->rain = $request->rain;
            $stat->humidity = $request->humidity;
            $stat->soil_moisture = $request->soil_moisture;
            $stat->save();
            $response = array(
                'status' => 200,
                'message' => 'OK'
            );
            return Response($response);
        }
        $response = array(
            'status' => 404,
            'message' => 'Device needs to be registered.',
        );
        return Response($response);
    }
    /**
     * Weather Stats for a location
     */
    public function weatherStat(Request $request)
    {
        $this->validate($request, [
            'device_id' => 'required',
        ]);

        $device_id = (int)  $request->device_id;

        if ($device_id == 0) {
            $device = Devices::orderBy('created_at')->first();
        } else {
            $device = Devices::find($device_id);
        }

        if ($device) {
            $stat = WeatherStats::where('device_id', $device->id)->first();

            if ($stat) {
                $response = array(
                    'status' => 200,
                    'message' => 'OK',
                    'datas' =>  array(
                        'device_id' => $device->id,
                        'device_key' => $device->device_key,
                        'location' => $device->location,
                        'temperature' => $stat->temperature,
                        'pressure' => $stat->pressure,
                        'rain' => $stat->rain,
                        'humidity' => $stat->humidity,
                        'soil_moisture' => $stat->soil_moisture,
                        'updated_at' => $stat->updated_at,
                    )
                );
                return Response($response);
            }
        }


        $response = array(
            'status' => 404,
            'message' => 'Some error occured!',
        );
        return Response($response);
    }


    public function deviceLocations()
    {
        $response = array(
            'status' => 200,
            'message' => 'OK',
            'datas' =>   Devices::all()
        );
        return Response($response);
    }
}
