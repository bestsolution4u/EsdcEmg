import 'package:flutter/material.dart';

class Routes {

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            ));
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}