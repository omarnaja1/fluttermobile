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

        backgroundColor: Colors.indigo,

        body: const Center(

        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        //  Image.asset('assets/images/icona_progetto.png'),
          Text(
         'Sviluppatori: Arduini Federico, Naja Omar',
           style: TextStyle(
              fontSize: 20),
         ),
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