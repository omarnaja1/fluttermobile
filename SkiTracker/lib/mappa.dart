import 'package:flutter/material.dart';

class Mappa extends StatefulWidget {
  const Mappa({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<Mappa> createState() => _MappaState();
}

class _MappaState extends State<Mappa> {

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

      backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mappa',
            ),
            Text(
              'Qui verra visualizzata la mappa',
            ),
          ],
        ),
      ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          onPressed: _geoLocation,
          tooltip: 'Increment',
          child: const Icon(Icons.location_on),
        )
    );
  }

}