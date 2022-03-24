class Editeur {
  int _id = 0;
  String _nom = "";
  String _adresse = "";

  Editeur(this._id, this._nom, this._adresse);
  Editeur.vide();

  int getIdEditeur() {
    return this._id;
  }

  String getNomEditeur() {
    return this._nom;
  }

  String getAdresseEditeur() {
    return this._adresse;
  }

  void setIdEditeur(int nvId) {
    this._id = nvId;
  }

  void setNomEditeur(String nvNom) {
    this._nom = nvNom;
  }

  void setadresseEditeur(String nvAdresse) {
    this._adresse = nvAdresse;
  }

  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _adresse == "" && _id == 0) {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | nom | adresse |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _adresse + " | ";
  }
}
