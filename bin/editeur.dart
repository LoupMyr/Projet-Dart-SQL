class Editeur {
  String nom;
  String adresse;

  Editeur(this.nom, this.adresse);

  String getNomEditeur() {
    return this.nom;
  }

  String getAdresseEditeur() {
    return this.adresse;
  }

  void setNomEditeur(String nvNom) {
    this.nom = nvNom;
  }

  void setadresseEditeur(String nvAdresse) {
    this.adresse = nvAdresse;
  }
}