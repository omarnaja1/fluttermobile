import 'package:SkiTracker/database/DbHelper.dart';
import 'package:SkiTracker/models/Comprensorio.dart';
import 'package:flutter/material.dart';

class SceltaComprensorio extends StatefulWidget {
  const SceltaComprensorio({super.key, required this.title});
  final String title;
  @override
  State<SceltaComprensorio> createState() => _SceltaComprensorioState();
}

class _SceltaComprensorioState extends State<SceltaComprensorio> {
  final Color titleColor = Colors.white;

  // per la ricerca dei comprensori sulla lista
  TextEditingController _textEditingController = TextEditingController();
  // Lista che si aggiorna dopo la ricerca
  List<Comprensorio> comprensoriOnSearch = [];

  // Elenco dei comprensori
  List<Comprensorio> comprensori = [];

  void initState() {
    super.initState();
    setListaComprensori();
  }

  Future<void> setListaComprensori() async {
    List<Comprensorio> comprensoriFromDb =
        await DbHelper().getListaComprensori();
    setState(() {
      this.comprensori = comprensoriFromDb;
    });
  }

  void setComprensorioSelezionato(int idComprensorio) {
    // imposto l'ID del comprensorio selezionato sul db
    DbHelper().setComprensorioSelezionato(idComprensorio);
    // chiudo questa vista e ritorno alla home
    Navigator.pop(context, idComprensorio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(203, 235, 236, 1.0),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  comprensoriOnSearch = comprensori
                      .where((element) => element.nome
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
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
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          backgroundColor: Color.fromRGBO(44, 124, 163, 1.0),
        ),
        body: _textEditingController.text.isNotEmpty &&
                comprensoriOnSearch.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 60,
                    color: Colors.red,
                  ),
                  Text(
                    'Nessun comprensorio trovato',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
            : ListView.builder(
                itemCount: _textEditingController.text.isNotEmpty
                    ? comprensoriOnSearch.length
                    : comprensori.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        late int selectedId;

                        if (_textEditingController.text.isNotEmpty)
                          selectedId = comprensoriOnSearch[index].id;
                        else
                          selectedId = comprensori[index].id;

                        this.setComprensorioSelezionato(selectedId);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.downhill_skiing_outlined),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _textEditingController.text.isNotEmpty
                                ? comprensoriOnSearch[index].nome
                                : comprensori[index].nome,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ));
                }));
  }
}
