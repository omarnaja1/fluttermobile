import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'dialogs.dart';

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
  MapController mapController = MapController();
  Position? currentPosition;
  List<Marker> markers = [];

  // Inizializzo lo StatefulWidget, andando ad ottenere la posizione GPS iniziale.
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  // Metodo asincrono che si occupa di ottenere la posizione iniziale.
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Controllo che sia abilitato il GPS sul telefono.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Servizio di localizzazione disabilitato!!
      AppDialogs().openDialog(context, "Errore", "É consigliato l'uso della posizione GPS per poter usare al meglio l'app. Per poter conoscere la tua posizione in tempo reale nella mappa, abilita la posizione GPS.");
      return;
    }

    // Controllo che l'utente abbia consentito l'accesso al GPS
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Se l'utente non ha mai consentito l'accesso al GPS, glielo chiedo
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permesso di localizzazione negato dall'utente!!!
        AppDialogs().openDialog(context, "Errore", "Non è possibile ottenere la posizione in tempo reale dell'utente perchè ne è stato negato l'accesso.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permesso di localizzazione negato permanentemente!!
      AppDialogs().openDialog(context, "Errore", "Il servizio di posizione GPS non è in esecuzione. Non sarà possibile conoscere la tua posizione in tempo reale sulla mappa.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
      markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(position.latitude, position.longitude),
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 50.0,
          ),
        ),
      ));
    });
  }

  // Se è nota la posizione dell'utente, centro la mappa sulla sua posizione.
  void centerMapOnPosition() {
    if (currentPosition != null)
      mapController.move(LatLng(currentPosition!.latitude, currentPosition!.longitude), 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(46.3678, 10.6593), // Posizione di default (Pejo)
            zoom: 13.0,
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'it.omarfederico.skitracker'
            ),
            MarkerLayer(
              markers: markers,
            )
          ],
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          tooltip: 'Increment',
          onPressed: centerMapOnPosition,
          child: const Icon(Icons.location_on, color: Colors.white),
        )
    );
  }

}