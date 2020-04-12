import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color color_1 = Color(0xfffff9ef);
    Color color_2 = Color(0xff201120);

    return Scaffold(
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
                if(selectedLocation != null){
                print(selectedLocation.name);

                }
              })
        ],
      ),
      body: SingleChildScrollView(
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
                        'Kathmandu, Nepal',
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
                          top: 5.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '-5 \u00b0 C',
                            style: TextStyle(
                              fontSize: 65.0,
                              // fontWeight: FontWeight.bold,
                              color: color_2,
                            ),
                          ),
                          Divider(
                            color: Color(0xffdfccab),
                            height: 10.0,
                          ), //dfccab
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //Water
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/water.png'),
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '73%',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      // fontWeight: FontWeight.bold,
                                      color: color_2,
                                    ),
                                  ),
                                ],
                              ),

                              //Wind
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/wind.png'),
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '12 m/s',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      // fontWeight: FontWeight.bold,
                                      color: color_2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
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
    List<Location> locations = <Location>[
      Location('Kathmandu', 1),
      Location('India', 2),
    ];
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
                  child: new Text(location.name),
                );
              }).toList(),
            ),
            // actions: <Widget>[
            //   FlatButton(
            //     child: Text('Ok'),
            //     onPressed: () {
            //       Navigator.of(context).pop(selectedLocation);
            //     },
            //   ),
            // ],
          );
        });
  }
}

class Location {
  const Location(this.name, this.id);
  final String name;
  final int id;
}

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather Monitoring'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//             color: Color(0xfffef4a9),
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 40.0,
//                   ),
//                   //location name
//                   Text(
//                     'Kathmandu, Nepal',
//                     style: TextStyle(
//                       fontSize: 28.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff071e3d),
//                     ),
//                   ),
//                   Text(
//                     formattedDate,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff071e3d),
//                     ),
//                   ),
//                   //temperature
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
