class Comprensorio {
  int id;
  String nome;
  int aperto;

  int numPiste;
  int numImpianti;

  String website;
  int snowpark;
  int pisteNotturne;

  double latitudine;
  double longitudine;

  int maxAltitudine;
  int minAltitudine;

  int zoom;

  // Costruttore
  Comprensorio(this.id, this.nome, this.aperto, this.numPiste, this.numImpianti, this.website, this.snowpark,
      this.pisteNotturne, this.latitudine, this.longitudine, this.maxAltitudine, this.minAltitudine, this.zoom);

  // Costruttore che prende in pasto un Row ottenuto da una query sul database
  factory Comprensorio.fromMap(Map<String, dynamic> map) {
    return Comprensorio(map['id'], map['nome'], map['aperto'], map['numPiste'], map['numImpianti'], map['website'],
        map['snowpark'], map['pisteNotturne'], map['lat'], map['long'], map['maxAltitudine'], map['minAltitudine'], map['zoom']);
  }
}