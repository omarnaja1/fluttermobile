import 'package:flutter/material.dart';

class SceltaComprensorio extends StatefulWidget{
  const SceltaComprensorio({super.key, required this.title});
  final String title;
  @override
  State<SceltaComprensorio> createState() => _SceltaComprensorioState();
}

class _SceltaComprensorioState extends State<SceltaComprensorio> {
  final Color titleColor = Colors.white;

  TextEditingController _textEditingController = TextEditingController();

  //Scrivo qui l'elenco di comprensori

  List<String> comprensori = [
    'Primo',
    'Secondo',
  ];

  // Lista che si aggiorna dopo la ricerca

  List<String> comprensoriOnSearch = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
           onChanged: (value) {
             setState(() {
               comprensoriOnSearch = comprensori.where((element) => element.toLowerCase().contains(value.toLowerCase())).toList();

             });
           },
          controller: _textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Cerca qui il comprensorio',

           ),
          ),
        ),

        backgroundColor: Color.fromRGBO(44, 124, 163, 1.0),
      ),
      body: _textEditingController!.text.isNotEmpty && comprensoriOnSearch.isEmpty
          ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 60,
                color: Colors.red,
              ),
              Text('Nessun comprensorio trovato',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          )
      )
          : ListView.builder(
        itemCount: _textEditingController!.text.isNotEmpty ? comprensoriOnSearch.length : comprensori.length,
          itemBuilder: (context, index){
            return Row(children: [
              CircleAvatar(child: Icon(Icons.downhill_skiing_outlined),
              ),
              SizedBox(
                width: 10,),
              Text(
                _textEditingController!.text.isNotEmpty ? comprensoriOnSearch[index] : comprensori[index],
                style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              ),
            ],
            );
          }),

    );
  }
}