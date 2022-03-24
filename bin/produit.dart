import 'auteur.dart';
import 'data.dart';
import 'editeur.dart';

class Produit implements Data {
  int _idP = 0;
  String _titre = "";
  Auteur _auteur = Auteur.vide();
  Editeur _editeur = Editeur.vide();
  String _type = "";
  int _prix = 0;
  int _nbDispo = 0;

  Produit(this._idP, this._titre, this._auteur, this._editeur, this._type,
      this._prix, this._nbDispo);
  Produit.vide();

  bool estNull() {
    bool estnull = false;
    if (_idP == 0 &&
        _titre == "" &&
        _type == "" &&
        _prix == 0 &&
        _nbDispo == 0 &&
        _auteur == Auteur.vide() &&
        _editeur == Editeur.vide()) {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| idP | titre | auteur | éditeur | type | prix | nbDispo |";
  }

  @override
  String getInLine() {
    return "| " +
        _idP.toString() +
        " | " +
        _titre +
        " | " +
        _auteur.toString() +
        " | " +
        _editeur.toString() +
        " | " +
        _type +
        " | " +
        _prix.toString() +
        " | " +
        _nbDispo.toString() +
        "|";
  }
}
