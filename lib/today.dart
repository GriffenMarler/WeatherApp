import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'package:intl/intl.dart';
import 'package:charcode/charcode.dart';
import 'dart:async';

// This is the Today Page class.
// This class shows current weather
// statustucs fir the users current location.
class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  String _res = "Unknown";
  // API key obtained from openweathermap.org for use with the Weather API
  String key = "525cefb69a1dc07575f901ffbb15c989";
  // Current weather information is stored here
  Weather w;
  WeatherStation ws;
  // Degree symbol for UI output
  String degree = String.fromCharCode($deg);

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(key);
    initPlatformState();
  }

// Assistance from https://pub.dev/packages/weather#-example-tab-
// In creating and implmenting these weather functions
  Future<void> initPlatformState() async {
    queryWeather();
  }

// This function queries the weather at the 
// devices current location and updates once
// complete. We then set the state to 
// refresh the widget and display data. 
  void queryWeather() async {
    w = await ws.currentWeather();

    setState(() {
      _res = w.toString();
    });
  }

  Widget build(BuildContext context) {
    // While the weather object is loading, return loading screen
    return w == null
        ? new Container(
            child: Center(child: Text("loading weather...")),
          )

        // Once loaded, return card with info.
        // This strategy was obtained from my software engineering project in Flutter.
        : new Card(
            child: Container(
              // https://alligator.io/flutter/flutter-gradient/
              // Above link helped me understand how to utilize
              // gradient patterns. 
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Colors.blue,
                  Colors.white,
                ])),
            // Create a column to layout the info
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    "Today's Weather",
                    style: GoogleFonts.lato(fontSize: 48),
                  ),
                ),

                Center(
                  child: Text(
                    w.areaName + " " + w.country,
                    style: GoogleFonts.lato(fontSize: 36),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Center(
                  child: Text(
                    "Current Temp: " +
                        w.temperature.fahrenheit.toStringAsPrecision(3) +
                        " " +
                        degree +
                        "F",
                    style: GoogleFonts.lato(fontSize: 24),
                   ),
                ),

                // Used the two links below to figure out how to display
                // the image from the openweathermapAPI that corresponds with
                // the correct weather conditions.
                // https://openweathermap.org/weather-conditions
                // https://flutter.dev/docs/cookbook/images/network-image
                Image.network('http://openweathermap.org/img/wn/' +
                    w.weatherIcon +
                    "@2x.png"),

                // All of the following widgets are wrapped in expanded 
                // So that we use the space properly and do not overflow
                Expanded(
                  child: ListTile(
                    leading:
                        Icon(Icons.event_note, size: 40, color: Colors.black),
                    title: Text(w.weatherDescription,
                        style: GoogleFonts.lato(fontSize: 24)),
                  ),
                ),

                Expanded(
                  child: ListTile(
                      leading: Image.asset("assets/tempmin.png"),
                      title: Text(
                          w.tempMin.fahrenheit.toStringAsPrecision(3) +
                              " " +
                              degree +
                              "F",
                          style: GoogleFonts.lato(fontSize: 24))),
                ),

                Expanded(
                  child: ListTile(
                    leading: Image.asset("assets/temperature.png"),
                    title: Text(
                        w.tempMax.fahrenheit.toStringAsPrecision(3) +
                            " " +
                            degree +
                            "F",
                        style: GoogleFonts.lato(fontSize: 24)),
                  ),
                ),

                Expanded(
                  child: ListTile(
                    leading:
                        Icon(Icons.wb_cloudy, size: 40, color: Colors.black),
                    title: Text(w.cloudiness.toString(),
                        style: GoogleFonts.lato(fontSize: 24)),
                  ),
                ),

                Expanded(
                  child: ListTile(
                    leading: Image.asset("assets/wind.png"),
                    title: Text(w.windSpeed.toStringAsPrecision(3) + " m/h",
                        style: GoogleFonts.lato(fontSize: 24)),
                  ),
                ),

                Expanded(
                  child: ListTile(
                    leading: Image.asset("assets/humidity.png"),
                    title: Text(w.humidity.toStringAsPrecision(3) + " %",
                        style: GoogleFonts.lato(fontSize: 24)),
                  ),
                ),
              ],
            ),
          ));
  }
}
