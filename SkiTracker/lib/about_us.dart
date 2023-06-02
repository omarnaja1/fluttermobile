import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget{
  const AboutUs({super.key});
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),

        body: Center(

        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/icona_progetto.png', //indirizzo
            width: 320, //lunghezza
            height: 100, //altezza
          ),

          SizedBox(height: 20), //spaziatura di 16px

          Text(
         'Sviluppatori: Arduini Federico, Naja Omar',
           style: TextStyle(
              fontSize: 20),
         ),

          SizedBox(height: 8),

          Text(
         'Versione: 1.0',
           style: TextStyle(
               fontSize: 20),
         ),
      ],
     ),
    ),
   );
  }
}