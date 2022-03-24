import 'data.dart';

class Auteur implements Data {
  int _id = 0;
  String _nom = "";
  String _prenom = "";

  Auteur(this._id, this._nom, this._prenom);
  Auteur.vide();

  String getNomAuteur() {
    return this._nom;
  }

  String getPrenomAuteur() {
    return this._prenom;
  }

  void setNomAuteur(String nvNom) {
    this._nom = nvNom;
  }

  void setPrenomAuteur(String nvPrenom) {
    this._prenom = nvPrenom;
  }

  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _prenom == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | nom | prenom |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _prenom + " | ";
  }
}
