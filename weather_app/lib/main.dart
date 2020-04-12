import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Weather Monitoring App',
      theme: ThemeData(
        // primaryColor: Color(0xffffb95e), 
        primaryColor: Color(0xfffef1da), 
        fontFamily: 'ZillaSlab',
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


 