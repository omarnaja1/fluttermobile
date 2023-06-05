import 'package:SkiTracker/scelta_comprensorio.dart';
import 'package:flutter/material.dart';

import 'database/DbHelper.dart';

class InfoPiste extends StatefulWidget{
  const InfoPiste({super.key});
  @override
  State<InfoPiste> createState() => _InfoPisteState();
}

class _InfoPisteState extends State<InfoPiste> {
  int? skiAreaId = 0;

  void initState() {
    super.initState();
    getSelectedSkiArea();
  }

  Future<void> getSelectedSkiArea() async {
    final id = await DbHelper.getComprensorioSelezionato();

    setState(() {
      if (id != null)
        this.skiAreaId = id;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text("data"),
                  new Text("data"),
                ],
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  SceltaComprensorio(title: 'Scegli Comprensorio',)),
            );

            // controllo se il widget scegliComprensorio ha chiesto di ricaricare questo
            // in seguito alla selezione di un comprensorio
            if (result != null) {
              setState(() {
                this.skiAreaId = result;
              });
            }
          },
          child: const Icon(Icons.change_circle, color: Colors.white),
        ),

    );
  }

}