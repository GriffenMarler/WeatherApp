import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'package:intl/intl.dart';
import 'package:charcode/charcode.dart';
import 'dart:async';

// The forecastPage class will be used to display
// 5 day forecast information at a users location. 
class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  String _res = "Unknown";
  // API key
  String key = "525cefb69a1dc07575f901ffbb15c989";

// List that forecast data will be put into
  List<Weather> f;
  WeatherStation ws;

  // Degree symbol
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

// Get the forecast data
// and refresh the widget
  void queryForecast() async {
    f = await ws.fiveDayForecast();
    setState(() {
      _res = f.toString();
    });
  }

  Widget build(BuildContext context) {
    // While the forecast object is loading, return loading screen
    return f == null
        ? new Container(
            child: Center(child: Text("loading forecast...")),
          )

        // Once loaded, return list view with forecast info.
        // https://www.youtube.com/watch?v=TdWhYERuv7g got me started with
        // how to implement the listview builder in a basic manner,
        // I then customized it for my application
        : new ListView.builder(
            // Create as many items as entries.
            // All the entries will use the same card format
            itemCount: f.length,
            itemBuilder: (context, index) {
              // Set background of each card
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
                          // Format the date for clean output
                          Text(
                            new DateFormat.yMMMMEEEEd()
                                .add_jm()
                                .format(f.elementAt(index).date),
                            style: GoogleFonts.lato(fontSize: 20),
                          ),

                          ListTile(
                            leading: Image.network(
                                'http://openweathermap.org/img/wn/' +
                                    f.elementAt(index).weatherIcon +
                                    "@2x.png"),
                            title: Text(f.elementAt(index).weatherDescription,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                )),
                            subtitle: Text(
                                "Temperature: " +
                                    f
                                        .elementAt(index)
                                        .temperature
                                        .fahrenheit
                                        .toStringAsPrecision(3) +
                                    " " +
                                    degree +
                                    "F",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                )),
                          ),
                        ],
                      )));
            });
  }
}
