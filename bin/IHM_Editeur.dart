import 'db_Editeur.dart';
import 'editeur.dart';
import 'IHM_P.dart';

class IhmEditeur {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Editeur");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IhmPrincipale.saisiInt(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmEditeur.menuSelectEdi();
      } else if (choix == 2) {
        await IhmEditeur.insertEditeur();
      } else if (choix == 3) {
        await IhmEditeur.updateEditeur();
      } else if (choix == 4) {
        await IhmEditeur.deleteEditeur();
      } else if (choix == 5) {
        await IhmEditeur.deleteAllEditeur();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  static Future<void> menuSelectEdi() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Editeur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IhmPrincipale.saisiInt(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmEditeur.selectEditeur();
      } else if (choix == 2) {
        await IhmEditeur.selectAllEditeur();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour ajouter un Etudiant
  static Future<void> insertEditeur() async {
    String nom = IhmPrincipale.saisieString();
    String adresse = IhmPrincipale.saisieString();
    await DbEditeur.insertEditeur(nom, adresse);
    print("Editeur inséré dans la table.");
    print("--------------------------------------------------");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour mettre a jour un Editeur selon ID
  static Future<void> updateEditeur() async {
    print("Quelle Editeur voulez vous mettre à jour ?");
    int id = IhmPrincipale.saisieID();
    if (await DbEditeur.exist(id)) {
      String nom = IhmPrincipale.saisieString();
      String adresse = IhmPrincipale.saisieString();
      await DbEditeur.updateEditeur(id, nom, adresse);
      print("Editeur $id mis à jour.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'Editeur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 2));
    }
  }

  // action pour afficher un Editeur selon ID
  static Future<void> selectEditeur() async {
    print("Quelle editeur voulez vous afficher ?");
    int id = IhmPrincipale.saisieID();
    Editeur etu = await DbEditeur.selectEditeur(id);
    if (!etu.estNull()) {
      IhmPrincipale.afficherUneDonnee(etu);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'etudiant $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour afficher les Editeur
  static Future<void> selectAllEditeur() async {
    List<Editeur> listeEdi = await DbEditeur.selectAllEditeur();
    if (listeEdi.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeEdi);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 2));
  }

// action pour supprimer un Editeur selon ID
  static Future<void> deleteEditeur() async {
    print("Quelle Editeur voulez vous supprimer ?");
    int id = IhmPrincipale.saisieID();
    DbEditeur.deleteEditeur(id);
    print("Editeur $id supprimé.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour supprimer les Editeur
  static Future<void> deleteAllEditeur() async {
    DbEditeur.deleteAllEditeur();
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }
}
