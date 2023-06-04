import 'package:SkiTracker/scelta_comprensorio.dart';
import 'package:flutter/material.dart';

import 'database/DbHelper.dart';

class InfoPiste extends StatefulWidget{
  const InfoPiste({super.key});
  @override
  State<InfoPiste> createState() => _InfoPisteState();
}

class _InfoPisteState extends State<InfoPiste> {
  var skiAreaId = 0;

  void initState() {
    super.initState();
    getSelectedSkiArea().then((value) => skiAreaId = value);
  }

  Future<int> getSelectedSkiArea() async {
    final id = await DbHelper.getComprensorioSelezionato();

    if (id == null)
      return 0;
    else
      return skiAreaId;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                skiAreaId.toString(),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  SceltaComprensorio(title: 'Scegli Comprensorio',)),
            );
          },
          child: const Icon(Icons.change_circle, color: Colors.white),
        ),

    );
  }

}