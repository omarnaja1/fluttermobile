import 'package:flutter/material.dart';

class Mappa extends StatelessWidget{

  int _counter = 0;

  void _geoLocation() {
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _geoLocation,
          //  tooltip: 'Increment',
          child: const Icon(Icons.location_on),
        )
    );
  }
}