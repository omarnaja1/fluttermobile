import 'package:flutter/material.dart';
import 'package:skitracker/scelta_comprensorio.dart';

class InfoPiste extends StatefulWidget{
  const InfoPiste({super.key});
  @override
  State<InfoPiste> createState() => _InfoPisteState();
}

class _InfoPisteState extends State<InfoPiste> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Info piste',
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SceltaComprensorio()),
            );
          },
          child: const Icon(Icons.change_circle),
        ),

    );
  }

}