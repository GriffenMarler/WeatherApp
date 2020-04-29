// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'forecast.dart' as weather;
import 'today.dart' as today;
import 'package:weather/weather.dart';
import 'package:json_string/json_string.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(home: new Tabs()));
}

// https://www.youtube.com/watch?v=3N27mjoBK2k
// The video above assisted me in understanding how
// to use the TabController to manage switching back
// and forth between Widgets.
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
            bottom: new TabBar(controller: controller, tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.home),
                text: ("Current"),
              ),
              new Tab(icon: new Icon(Icons.calendar_today), text: ("Forecast")),
            ])),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[new today.TodayPage(), new weather.ForecastPage()],
        )
        
        );
  }
}
