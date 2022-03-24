import 'IHM_P.dart';
import 'auteur.dart';
import 'db_Auteur.dart';

class IhmAuteur {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Etudiants");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IhmPrincipale.saisiInt(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmAuteur.menuSelectAuteur();
      } else if (choix == 2) {
        await IhmAuteur.insertAuteur();
      } else if (choix == 3) {
        await IhmAuteur.updateAuteur();
      } else if (choix == 4) {
        await IhmAuteur.deleteAuteur();
      } else if (choix == 5) {
        await IhmAuteur.deleteAllAuteurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectAuteur() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Auteur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IhmPrincipale.saisiInt(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmAuteur.selectAuteur();
      } else if (choix == 2) {
        await IhmAuteur.selectAllAuteurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Etudiant
  static Future<void> insertAuteur() async {
    String nom = IhmPrincipale.saisieString();
    String prenom = IhmPrincipale.saisieString();
    await DbAuteur.insertAuteur(nom, prenom);
    print("Etudiant inséré dans la table.");
    print("--------------------------------------------------");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Etudiant selon ID
  static Future<void> updateAuteur() async {
    print("Quelle Etudiant voulez vous mettre à jour ?");
    int id = IhmPrincipale.saisieID();
    if (await DbAuteur.exist(id)) {
      String nom = IhmPrincipale.saisieString();
      String prenom = IhmPrincipale.saisieString();
      await DbAuteur.updateAuteur(id, nom, prenom);
      print("Etudiant $id mis à jour.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'étudiant $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un Etudiant selon ID
  static Future<void> selectAuteur() async {
    print("Quelle auteur voulez vous afficher ?");
    int id = IhmPrincipale.saisieID();
    Auteur etu = await DbAuteur.selectAuteur(id);
    if (!etu.estNull()) {
      IhmPrincipale.afficherUneDonnee(etu);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'etudiant $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les Etudiants
  static Future<void> selectAllAuteurs() async {
    List<Auteur> listeEtu = await DbAuteur.selectAllAuteur();
    if (listeEtu.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeEtu);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer un Etudiant selon ID
  static Future<void> deleteAuteur() async {
    print("Quelle Etudiant voulez vous supprimer ?");
    int id = IhmPrincipale.saisieID();
    DbAuteur.deleteAuteur(id);
    print("Etudiant $id supprimé.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour supprimer les Etudiants
  static Future<void> deleteAllAuteurs() async {
    DbAuteur.deleteAllAuteurs();
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }
}
