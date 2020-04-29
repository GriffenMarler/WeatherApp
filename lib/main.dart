// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// https://www.youtube.com/watch?v=3N27mjoBK2k

import 'package:flutter/material.dart';
import 'forecast.dart' as weather;
import 'today.dart' as today ;
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'dart:async';

void main() {
runApp(new MaterialApp(
  home: new Tabs() 
));
} 


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override  

  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);

  }

 @override
 void dispose() {
   controller.dispose();
   super.dispose();
 } 

  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Weather"),
        bottom: new TabBar(controller: controller,
        tabs: <Tab> [
          new Tab(icon: new Icon(Icons.home)),
          new Tab(icon: new Icon(Icons.calendar_today)),
        ])),
      body: new TabBarView(controller: controller, 
      children: <Widget>[ new today.TodayPage(),
      new weather.ForecastPage() ],)

      
     );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _res = "Unknown";
//   String key = "525cefb69a1dc07575f901ffbb15c989";
//   JsonString json;
//   Weather w;
//   WeatherStation ws;

// int _currentindex = 0;

//   @override
//   void initState() {
//     super.initState();
//     ws = new WeatherStation(key);
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     queryWeather();
//   }

//   void queryForecast() async {
//     List<Weather> f = await ws.fiveDayForecast();
//     setState(() {
//       _res = f.toString();
//     });
//   }

//   void queryWeather() async {
//     w = await ws.currentWeather();

//     setState(() {
//       _res = w.toString();
//     });
//   }

//   Widget build(BuildContext context) {
//     queryWeather();
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My Weather'),
//         ),
//         body: Stack(
//           children: <Widget>[
//             Container(
//               // https://stackoverflow.com/questions/44179889/flutter-sdk-set-background-image
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                     Colors.blue,
//                     Colors.deepOrange,
//                   ])),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _currentindex,
//           items : [BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text("Current"),
//             backgroundColor: Colors.blue
//           ),
//             BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             title: Text("Forecast"),
//             backgroundColor: Colors.blue
//           )
//            ],
//            onTap: (index) {
//               setState(() {
//                 _currentindex = index;
//               });
//            }) ,
//       ),
//     );
//   }
// }
