<?php

namespace App\Http\Controllers;

use App\Devices;
use App\WeatherStats;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        //get devices with data
        $devices = array();

        foreach (Devices::all() as $device) {


            $stat = WeatherStats::where('device_id', $device->id)->first();

            if ($stat) {
                array_push($devices, array(
                    'devices_id' => $device->id,
                    'location' => $device->location,
                    'device_key' => $device->device_key,
                    'temperature' => $stat->temperature,
                    'pressure' => $stat->pressure,
                    'rain' => $stat->rain,
                    'humidity' => $stat->humidity,
                    'soil_moisture' => $stat->soil_moisture,
                    'updated_at' => $stat->updated_at,

                ));
            } else {
                $device->delete();
                continue;
            }
        }
        return view('home.index', compact('devices'));
    }
    public function addNewDevice(Request $request)
    {
        $this->validate($request, [
            'location' => 'required',
            'device_key' => 'required'
        ]);


        //Check if key already exists
        if (Devices::where('device_key', $request->device_key)->count() == 0 && WeatherStats::where('device_key', $request->device_key)->count() == 0) {

            $device = new Devices();
            $device->location = $request->location;
            $device->device_key = $request->device_key;
            $device->save();

            $stat = new WeatherStats();
            $stat->device_id = $device->id;
            $stat->device_key = $request->device_key;

            $stat->temperature = '0';
            $stat->pressure = '0';
            $stat->rain = '0';
            $stat->humidity = '0';
            $stat->soil_moisture = '0';
            $stat->save();
        }

        return redirect('/');
    }

    public function removeDevice($device_id)
    {

        Devices::where('id', $device_id)->delete();
        WeatherStats::where('device_id', $device_id)->delete();


        return redirect('/');
    }
}
