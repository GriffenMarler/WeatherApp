import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'package:intl/intl.dart';
import 'package:charcode/charcode.dart';
import 'dart:async';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  String _res = "Unknown";
  String key = "525cefb69a1dc07575f901ffbb15c989";
  JsonString json;
  Weather w;
  List <Weather> f;
  WeatherStation ws;
   String degree = String.fromCharCode($deg);

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    initPlatformState();
  }

// Assistance from https://pub.dev/packages/weather#-example-tab-
// In creating and implmenting these functions
  Future<void> initPlatformState() async {
    queryForecast();
  }

  void queryForecast() async {
    f = await ws.fiveDayForecast();
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
    // While the weather object is loading, return loading screen
    return f == null
        ? new Container(
            child: Center(child: Text("loading forecast...")),
          )

        // Once loaded, return card with info.
        // This strategy was obtained from my software engineering project in Flutter
        : new ListView.builder(
          itemCount: f.length,
          itemBuilder: (context, index) {
            return Card(
                        child: Container(
            decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.white,
                    Colors.blue,
                  ])),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    // https://api.flutter.dev/flutter/intl/DateFormat-class.html
                    Text(new DateFormat.yMMMMEEEEd().add_jm().format(f.elementAt(index).date),
                    style: GoogleFonts.lato(
                        fontSize:20
                      ),),
                  
                      ListTile(
                        leading: Image.network(
                    'http://openweathermap.org/img/wn/' + f.elementAt(index).weatherIcon + "@2x.png"
                  ),
                  title: Text(f.elementAt(index).weatherDescription,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                  )),
                  subtitle: Text("Temperature: " + f.elementAt(index).temperature.fahrenheit.toStringAsPrecision(3) + " " + degree + 
                  "F", 
                   style: GoogleFonts.lato(
                    fontSize: 16,
                  )),

  
            ),
                ],
                               
              )));
          }
        );
  }
}
