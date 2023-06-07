import 'package:xml/xml.dart' as xml;
import '../models/Pista.dart';

class OSMWayTag {
  late String k;
  late String v;

  OSMWayTag(String k, String v) {
    this.k = k;
    this.v = v;
  }
}

class OSMWay {
  late int id;
  late List<int> nodesId;
  late List<OSMWayTag> tags;

  OSMWay(int id, List<int> nodesId, List<OSMWayTag> tags) {
    this.id = id;
    this.nodesId = nodesId;
    this.tags = tags;
  }
}

class OSMNode {
  late int id;
  late double lat;
  late double long;

  OSMNode(int id, double lat, double long) {
    this.id = id;
    this.lat = lat;
    this.long = long;
  }
}

class OsmXmlAnalyzer {
  List<OSMWay> getWays(xml.XmlDocument document) {
    List<OSMWay> ways = [];

    var wayNodes = document.findAllElements("way");
    for (var i = 0; i < wayNodes.length; i++) {
      var wayNode = wayNodes.elementAt(i);
      int wayId = int.parse(wayNode.getAttribute("id")!);

      var ndNodes = wayNode.childElements;
      List<int> nodeIds = [];
      List<OSMWayTag> nodeTags = [];

      for (var j = 0; j < ndNodes.length; j++) {
        var ndNode = ndNodes.elementAt(j);
        if (ndNode.name.toString() == "nd") {
          int nodeId = int.parse(ndNode.getAttribute("ref")!);
          nodeIds.add(nodeId);
        }
        if (ndNode.name.toString() == "tag") {
          String? k = ndNode.getAttribute("k");
          String? v = ndNode.getAttribute("v");
          nodeTags.add(OSMWayTag(k!, v!));
        }
      }

      OSMWay way = OSMWay(wayId, nodeIds, nodeTags);
      ways.add(way);
    }

    return ways;
  }

  List<Pista> getPisteList(xml.XmlDocument document, int comprensorioId) {
    var ways = this.getWays(document);
    List<Pista> listaPiste = [];

    for (var way in ways) {
      List<OSMWayTag> wayTags = way.tags;
      String difficulty = "no";
      String nome = "no";

      for (var tag in wayTags) {
        if (tag.k == "piste:difficulty")
          difficulty = tag.v;
        else if (tag.k == "piste:name" || tag.k == "name")
          nome = tag.v;
      }

      if (nome != "no" && difficulty != "no") {
        Pista p = Pista(nome, difficulty, way.id, comprensorioId);
        listaPiste.add(p);
      }
    }

    listaPiste = this.removeDuplicatePistas(listaPiste);
    return listaPiste;
  }

  List<Pista> removeDuplicatePistas(List<Pista> originalList) {
    List<String> nomiUsati = [];
    List<Pista> output = [];

    for (var i = 0; i < originalList.length; i++) {
      String nome = originalList[i].nome;
      if (!nomiUsati.contains(nome)) {
        output.add(originalList[i]);
        nomiUsati.add(nome);
      } else {
        for (int j = 0; j < output.length; j++) {
          if (output[j].nome == nome) {
            output[j] = originalList[i];
          }
        }
      }
    }

    return output;
  }
}