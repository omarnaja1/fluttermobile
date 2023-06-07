import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'database/DbHelper.dart';
import 'dialogs.dart';
import 'models/Comprensorio.dart';

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
  Comprensorio? mySkiArea = null;

  // Inizializzo lo StatefulWidget, andando ad ottenere la posizione GPS iniziale.
  @override
  void initState() {
    super.initState();
    getSelectedSkiArea();
    checkForLocationPermission();
  }

  Future<void> getSelectedSkiArea() async {
    final id = await DbHelper.getComprensorioSelezionato();

    if (id != null) {
      final skiArea = await DbHelper().getDettagliComprensorio(id);

      if (skiArea != null) {
        setState(() {
          this.mySkiArea = skiArea;
        });
      }
    }
  }

  // Controlla se l'utente ha consentito l'accesso alla posizione GPS. Se non lo ha fatto, glielo chiede.
  Future<void> checkForLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Controllo che sia abilitato il GPS sul telefono.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Servizio di localizzazione disabilitato!!
      AppDialogs().openDialog(context, "Errore",
          "É consigliato l'uso della posizione GPS per poter usare al meglio l'app. Per poter conoscere la tua posizione in tempo reale nella mappa, abilita la posizione GPS.");
      return;
    }

    // Controllo che l'utente abbia consentito l'accesso al GPS
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Se l'utente non ha mai consentito l'accesso al GPS, glielo chiedo
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permesso di localizzazione negato dall'utente!!!
        AppDialogs().openDialog(context, "Errore",
            "Non è possibile ottenere la posizione in tempo reale dell'utente perchè ne è stato negato l'accesso.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permesso di localizzazione negato permanentemente!!
      AppDialogs().openDialog(context, "Errore",
          "Il servizio di posizione GPS non è in esecuzione. Non sarà possibile conoscere la tua posizione in tempo reale sulla mappa.");
      return;
    }

    // Ora che ho i permessi di farlo vado ad ottenere la posizione GPS
    this.getCurrentGPSLocation();
  }

  // Ottiene la posizione dal GPS e imposta un marker che punta su di questa nella mappa
  Future<Position> getCurrentGPSLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = position;

      if (markers.isNotEmpty) markers.removeLast();

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

    return position;
  }

  // Ripete la richiesta di posizione GPS, e una volta ottenuta centra la mappa su di questa
  Future<void> refreshPosition() async {
    Position position = await getCurrentGPSLocation();
    mapController.move(LatLng(position.latitude, position.longitude), 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),
        body: Visibility(
          visible: this.mySkiArea != null,
          replacement: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/waiting_map.png',
                width: 125,
              ),
              SizedBox(height: 10),
              Text(
                "Passa nella scheda Info comprensorio per selezionare il comprensorio.",
                style: TextStyle(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              )
            ]),
          ),
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(this.mySkiArea?.latitudine ?? 0.0,
                  this.mySkiArea?.longitudine ?? 0.0),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'it.omarfederico.skitracker'),
              MarkerLayer(
                markers: markers,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          tooltip: 'Aggiorna posizione',
          onPressed: refreshPosition,
          child: const Icon(Icons.location_on, color: Colors.white),
        ));
  }
}
