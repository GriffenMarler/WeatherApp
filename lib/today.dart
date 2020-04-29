import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'package:intl/intl.dart';
import 'dart:async';
 
 
 
 class TodayPage extends StatefulWidget {
   @override
   _TodayPageState createState() => _TodayPageState();
 }
 
 class _TodayPageState extends State<TodayPage> {

     String _res = "Unknown";
  String key = "525cefb69a1dc07575f901ffbb15c989";
  JsonString json;
  Weather w;
  WeatherStation ws;

//  https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart
  var timeformatter = new DateFormat("jm");

   @override
  



  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    queryWeather();
  }

  void queryForecast() async {
    List<Weather> f = await ws.fiveDayForecast();
    setState(() {
      _res = f.toString();
    });
  }

  void queryWeather() async {
    w = await ws.currentWeather();

    setState(() {
      _res = w.toString();
    });

  }
   Widget build(BuildContext context) {
     return new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text("Today's Weather",
                style: GoogleFonts.lato(
                  fontSize: 48
                ),),
               
              ),

               Center(
                  child: Text(w.areaName + " " + w.country,
                  style: GoogleFonts.lato(
                    fontSize:36
                  ),),
                  ),

              Center(
            child: Text( "Current Temp: (Fahrenheit): " +
                   w.temperature.fahrenheit.toStringAsPrecision(3),
                   style: GoogleFonts.lato(
                     fontSize: 24
                   ),),
                ),

// https://openweathermap.org/weather-conditions
// https://flutter.dev/docs/cookbook/images/network-image
              Image.network(
                'http://openweathermap.org/img/wn/' + w.weatherIcon + "@2x.png"
              ),


              ListTile(
              leading: Icon(Icons.event_note,
              size: 40),
              title: Text(w.weatherDescription, style: GoogleFonts.lato(
                fontSize: 24
              )),
              ),
              Row
               (children: <Widget>[
                  Expanded(
                                      child: ListTile(
                      leading: Icon(Icons.brightness_low, 
                      size: 40),
                      title: Text(w.tempMin.fahrenheit.toStringAsPrecision(3), )
                    ),

    
                  ),


                  Expanded(
                    child: ListTile(
                      leading: Icon(Icons.brightness_high,
                      size: 40),
                      title: Text(w.tempMax.fahrenheit.toStringAsPrecision(3),
                    ),
                  ),
                  )   ],),

                   ListTile(
              leading: Icon(Icons.wb_cloudy,
              size: 40),
              title: Text(w.cloudiness.toString(), style: GoogleFonts.lato(
                fontSize: 24
              )),
              ),

                  // Expanded(child: ListTile(
                  //   leading: Icon(Icons.wb_sunny,
                  //   size: 40),
                  //   title: Text(timeformatter.format(w.sunrise.toLocal()),
                  // ),) ),

                  
              // 
            ],)
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
