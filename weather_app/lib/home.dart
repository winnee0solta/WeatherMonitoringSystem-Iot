import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weatherstat.dart';
import 'dart:convert';
//screens
import 'helpers/api_helper.dart';
import 'model/location.dart';
import 'widgets/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Location> locations = new List<Location>();
  WeatherStat weatherStat;

  @override
  Widget build(BuildContext context) {
    Color color_1 = Color(0xfffff9ef);
    Color color_2 = Color(0xff201120);

    var textfontsize = 20.0;
    var iconssize = 20.0;

    Widget temperature = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: AssetImage('assets/images/temperature.png'),
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover),
        ),
        Text(
          weatherStat == null ? '' : '${weatherStat.temperature} \u00b0 C',
          style: TextStyle(
            fontSize: 50.0,
            // fontWeight: FontWeight.bold,
            color: color_2,
          ),
        ),
      ],
    );
    Widget pressure = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: AssetImage('assets/images/pressure.png'),
              height: iconssize,
              width: iconssize,
              fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          weatherStat == null ? '' : '${weatherStat.pressure} mb',
          style: TextStyle(
            fontSize: textfontsize,
            // fontWeight: FontWeight.bold,
            color: color_2,
          ),
        ),
      ],
    );
    Widget rain = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: AssetImage('assets/images/rain.png'),
              height: iconssize,
              width: iconssize,
              fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          weatherStat == null ? '' : '${weatherStat.rain} %',
          style: TextStyle(
            fontSize: textfontsize,
            // fontWeight: FontWeight.bold,
            color: color_2,
          ),
        ),
      ],
    );
    Widget humidity = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: AssetImage('assets/images/humidity.png'),
              height: iconssize,
              width: iconssize,
              fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          weatherStat == null ? '' : '${weatherStat.humidity} %',
          style: TextStyle(
            fontSize: textfontsize,
            color: color_2,
          ),
        ),
      ],
    );
    Widget soilmoisture = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image(
              image: AssetImage('assets/images/soil.png'),
              height: iconssize,
              width: iconssize,
              fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          weatherStat == null ? '' : '${weatherStat.soilmoisture} %',
          style: TextStyle(
            fontSize: textfontsize,
            color: color_2,
          ),
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Weather Monitoring',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.location_searching),
              onPressed: () async {
                Location selectedLocation = await _chooseLocation(context);
                if (selectedLocation != null) {
                  _populateWeatherStats(deviceid: selectedLocation.deviceid);
                  print(selectedLocation.deviceid);
                }
              })
        ],
      ),
      body: (isloading || weatherStat == null)
          ? LoadingLayout()
          : SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg_1.png"),
                          fit: BoxFit.cover)),
                  // color: Color(0xfffef4a9),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),

                        //location
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: color_1,
                            ),
                            Text(
                              weatherStat == null
                                  ? ''
                                  : '${weatherStat.location}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: color_1,
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 10.0,
                        ),

                        Card(
                          color: Color(0xfffef3df),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0,
                                bottom: 20.0,
                                left: 20.0,
                                right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                temperature,
                                Divider(
                                  color: Colors.grey,
                                  // color: Color(0xffdfccab),
                                  height: 10.0,
                                ), //dfccab
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    //Pressure
                                    pressure,
                                    //Rain
                                    rain,
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    //Humidity
                                    humidity,
                                    //Soil Moisture
                                    soilmoisture,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }

  Future<Location> _chooseLocation(BuildContext context) async {
    return showDialog<Location>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Location'),
            content: DropdownButton<Location>(
              hint: Text("Choose Location"),
              // hint: selectedLocation == null ? Text("Choose") : Text(selectedLocation.name) ,

              onChanged: (Location location) {
                setState(() {
                  Navigator.of(context).pop(location);
                });
              },
              items: locations.map((Location location) {
                return new DropdownMenuItem<Location>(
                  value: location,
                  child: new Text(location.location),
                );
              }).toList(),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _populateLocations();
    _populateWeatherStats();
  }

  void _populateLocations() {
    setState(() {
      isloading = true;
    });
    _fetchLocations().then((list) {
      //  print(list);
      setState(() {
        isloading = false;
        locations = list;
      });
    });
  }

  void _populateWeatherStats({String deviceid = '0'}) {
    setState(() {
      isloading = true;
    });
    _fetchWeatherStat(deviceid).then((list) {
      //  print(list);
      setState(() {
        isloading = false;
        weatherStat = list;
      });
    });
  }

  Future<List<Location>> _fetchLocations() async {
    var url = ApiHelper.locations;
    var response = await http.get(url, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      // print(responseJson['datas']);

      final items =
          (responseJson["datas"] as List).map((i) => new Location.fromJson(i));
      return items.toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<WeatherStat> _fetchWeatherStat(String deviceid) async {
    var url = ApiHelper.fetchweatherstats;
    var response = await http.post(url, body: {
      'device_id': deviceid.toString(), //need to send as string
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Response body: ${response.body}');
      var responseJson = json.decode(response.body);
      print(responseJson['datas']);

      return new WeatherStat.fromJson(responseJson["datas"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
