import 'data.dart';

class Produit implements Data {
  int _id = 0;
  String _titre = "";
  int _idAuteur = 0;
  int _idEditeur = 0;
  String _type = "";
  int _prix = 0;
  int _nbDispo = 0;

  Produit(this._id, this._titre, this._idAuteur, this._idEditeur, this._type,
      this._prix, this._nbDispo);
  Produit.vide();

  bool estNull() {
    bool estnull = false;
    if (_id == 0 &&
        _titre == "" &&
        _type == "" &&
        _prix == 0 &&
        _nbDispo == 0 &&
        _idAuteur == 0 &&
        _idEditeur == 0) {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | titre | auteur | éditeur | type | prix | nbDispo |";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _titre +
        " | " +
        _idAuteur.toString() +
        " | " +
        _idEditeur.toString() +
        " | " +
        _type +
        " | " +
        _prix.toString() +
        " | " +
        _nbDispo.toString() +
        "|";
  }
}
