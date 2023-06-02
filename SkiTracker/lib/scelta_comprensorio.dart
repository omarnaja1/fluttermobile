import 'package:flutter/material.dart';

class SceltaComprensorio extends StatefulWidget{
  const SceltaComprensorio({super.key});
  @override
  State<SceltaComprensorio> createState() => _SceltaComprensorioState();
}

class _SceltaComprensorioState extends State<SceltaComprensorio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seconda Schermata'),
      ),
      body: Center(
        child: Text('Scelta comprensorio'),
      ),
    );
  }
}