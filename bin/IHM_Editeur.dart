import 'package:mysql1/mysql1.dart';

import 'db_Editeur.dart';
import 'editeur.dart';
import 'IHM_P.dart';

class IhmEditeur {
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Editeur");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IhmPrincipale.saisiChoix(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmEditeur.menuSelectEdi(settings);
      } else if (choix == 2) {
        await IhmEditeur.insertEditeur(settings);
      } else if (choix == 3) {
        await IhmEditeur.updateEditeur(settings);
      } else if (choix == 4) {
        await IhmEditeur.deleteEditeur(settings);
      } else if (choix == 5) {
        await IhmEditeur.deleteAllEditeur(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  static Future<void> menuSelectEdi(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Editeur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IhmPrincipale.saisiChoix(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmEditeur.selectEditeur(settings);
      } else if (choix == 2) {
        await IhmEditeur.selectAllEditeur(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour ajouter un editeur
  static Future<void> insertEditeur(ConnectionSettings settings) async {
    String nom = IhmPrincipale.saisieString("le nom");
    String adresse = IhmPrincipale.saisieString("l'adresse");
    await DbEditeur.insertEditeur(settings, nom, adresse);
    print("Editeur inséré dans la table.");
    print("--------------------------------------------------");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour mettre a jour un Editeur selon ID
  static Future<void> updateEditeur(ConnectionSettings settings) async {
    print("Quelle Editeur voulez vous mettre à jour ?");
    int id = IhmPrincipale.saisieID();
    if (await DbEditeur.exist(settings, id)) {
      String nom = IhmPrincipale.saisieString("le nom");
      String adresse = IhmPrincipale.saisieString("l'adresse");
      await DbEditeur.updateEditeur(settings, id, nom, adresse);
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
  static Future<void> selectEditeur(ConnectionSettings settings) async {
    print("Quelle editeur voulez vous afficher ?");
    int id = IhmPrincipale.saisieID();
    Editeur editeur = await DbEditeur.selectEditeur(settings, id);
    if (!editeur.estNull()) {
      IhmPrincipale.afficherUneDonnee(editeur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour afficher les Editeur
  static Future<void> selectAllEditeur(ConnectionSettings settings) async {
    List<Editeur> listeEditeur = await DbEditeur.selectAllEditeur(settings);
    if (listeEditeur.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeEditeur);
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
  static Future<void> deleteEditeur(ConnectionSettings settings) async {
    print("Quelle Editeur voulez vous supprimer ?");
    int id = IhmPrincipale.saisieID();
    DbEditeur.deleteEditeur(settings, id);
    print("Editeur $id supprimé.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour supprimer les Editeur
  static Future<void> deleteAllEditeur(ConnectionSettings settings) async {
    DbEditeur.deleteAllEditeur(settings);
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }
}
