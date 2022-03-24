class Auteur {
  String nom;
  String prenom;

  Auteur(this.nom, this.prenom);

  String getNomAuteur() {
    return this.nom;
  }

  String getPrenomAuteur() {
    return this.prenom;
  }

  void setNomAuteur(String nvNom) {
    this.nom = nvNom;
  }

  void setPrenomAuteur(String nvPrenom) {
    this.prenom = nvPrenom;
  }
}
