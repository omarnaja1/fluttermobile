import 'package:SkiTracker/scelta_comprensorio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'database/DbHelper.dart';

class InfoPiste extends StatefulWidget{
  const InfoPiste({super.key});
  @override
  State<InfoPiste> createState() => _InfoPisteState();
}

class _InfoPisteState extends State<InfoPiste> {
  int? skiAreaId = 0;
  String? nomeComprensorio = "";
  int? stato = 1;
  int? numPisteComrprensorio = 0;
  String? sitoComprensorio = "";
  int? numImpiantiRisalitaComprensorio = 0;
  int? altMinComprensorio = 0;
  int? altMaxComprensorio = 0;

  // Elenco delle piste
 // List<Piste> piste = [];
  List<String> piste = [
    "prima", "seconda", "terza", "quarta", "quinta", "sesta", "settima", "ottava"
  ];

  void initState() {
    super.initState();
    getSelectedSkiArea();
  }

  Future<void> getSelectedSkiArea() async {
    final id = await DbHelper.getComprensorioSelezionato();
    final nome = await DbHelper.getNomeComprensorioSelezionato();
    final aperto = await DbHelper.getStatoComprensorioSelezionato();
    final sito  = await DbHelper.getSitoComprensorioSelezionato();
    final numPiste  = await DbHelper.getNumPisteComprensorioSelezionato();
    final impiantiRisalita = await DbHelper.getImpiantiRisalitaComprensorioSelezionato();
    final altMin = await DbHelper.getAltMinComprensorioSelezionato();
    final altMax = await DbHelper.getAltMaxComprensorioSelezionato();

    setState(() {
      if (id != null)
        this.skiAreaId = id;
        this.nomeComprensorio = nome;
        this.stato = aperto;
        this.sitoComprensorio = sito;
        this.numPisteComrprensorio = numPiste;
        this.numImpiantiRisalitaComprensorio = impiantiRisalita;
        this.altMinComprensorio = altMin;
        this.altMaxComprensorio = altMax;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 10),

          Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$nomeComprensorio",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 35,
            ),
          ),
          Text("Aperto",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🏂 Numero di piste: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text("$numPisteComrprensorio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🚡 Impianti di risalita: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text("$numImpiantiRisalitaComprensorio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("⛰ Altitudine minima: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text("$altMinComprensorio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("🏔 Altitudine massima: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text("$altMaxComprensorio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sito: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              GestureDetector(
                onTap: () => launch(sitoComprensorio!),
                child: Text("$sitoComprensorio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Snowpark",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35,
                  backgroundColor: Colors.white,
                ),
              ),
              Text("Piste notturne",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35,
                  backgroundColor: Color.fromRGBO(37, 40, 80, 1),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),


          Text("Elenco piste",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 35,
            ),
          ),

      Expanded(
        child: ListView.builder(


              itemCount: piste.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(piste[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                );
              }),
      ),


//COME DOVRA' ESSERE LA LISTVIEW
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
              Text("Difficolta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35,
                  backgroundColor: Color.fromRGBO(37, 40, 80, 1),
                ),
              ),
            ],
          ),
           */


        ],
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