import 'package:SkiTracker/scelta_comprensorio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'database/DbHelper.dart';
import 'models/Pista.dart';

const double PADDING_VERTICAL = 3;
const double PADDING_HORIZONTAL = 20;
const double INDICATORS_SIZE = 18;

class InfoPiste extends StatefulWidget {
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
  int? snowparkComprensorio = 0;
  int? pisteNotturneComprensorio = 0;

  // Elenco delle piste
  // List<Piste> piste = [];
  List<Pista> piste = [
    Pista("Pista1", "novice"),
    Pista("Pista2", "easy"),
    Pista("Pista3", "intermediate"),
    Pista("Pista4", "advanced"),
    Pista("Pista5", "novice"),
  ];

  void initState() {
    super.initState();
    getSelectedSkiArea();
  }

  Future<void> getSelectedSkiArea() async {
    final id = await DbHelper.getComprensorioSelezionato();
    final nome = await DbHelper.getNomeComprensorioSelezionato();
    final aperto = await DbHelper.getStatoComprensorioSelezionato();
    final sito = await DbHelper.getSitoComprensorioSelezionato();
    final numPiste = await DbHelper.getNumPisteComprensorioSelezionato();
    final impiantiRisalita =
        await DbHelper.getImpiantiRisalitaComprensorioSelezionato();
    final altMin = await DbHelper.getAltMinComprensorioSelezionato();
    final altMax = await DbHelper.getAltMaxComprensorioSelezionato();
    final snowpark = await DbHelper.getSnowparkComprensorioSelezionato();
    final pisteNotturne =
        await DbHelper.getPistaNotturnaComprensorioSelezionato();

    setState(() {
      if (id != null) this.skiAreaId = id;
      this.nomeComprensorio = nome;
      this.stato = aperto;
      this.sitoComprensorio = sito;
      this.numPisteComrprensorio = numPiste;
      this.numImpiantiRisalitaComprensorio = impiantiRisalita;
      this.altMinComprensorio = altMin;
      this.altMaxComprensorio = altMax;
      this.snowparkComprensorio = snowpark;
      this.pisteNotturneComprensorio = pisteNotturne;
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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$nomeComprensorio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "Aperto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                    backgroundColor: stato == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🏂 Numero di piste: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
                Text(
                  "$numPisteComrprensorio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🚡 Impianti di risalita: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
                Text(
                  "$numImpiantiRisalitaComprensorio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "⛰ Altitudine minima: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
                Text(
                  "$altMinComprensorio m s.l.m.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🏔 Altitudine massima: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
                Text(
                  "$altMaxComprensorio m s.l.m.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sito: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: INDICATORS_SIZE,
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrlString(sitoComprensorio!),
                  child: Text(
                    "$sitoComprensorio",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: INDICATORS_SIZE,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: snowparkComprensorio == 1,
                  child: Text(
                    "✅ Snowpark",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                Visibility(
                  visible: pisteNotturneComprensorio == 1,
                  child: Text(
                    "✅ Piste notturne",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: PADDING_VERTICAL, horizontal: PADDING_HORIZONTAL),
            child: Text(
              "Elenco piste",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: piste.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: PADDING_VERTICAL,
                          horizontal: PADDING_HORIZONTAL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            piste[index].nome,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            piste[index].getDifficultyWithIndicator(),
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(161, 149, 200, 1.0),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SceltaComprensorio(
                      title: 'Scegli Comprensorio',
                    )),
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
