import 'package:mysql1/mysql1.dart';

import 'IHM_P.dart';
import 'auteur.dart';
import 'db_Auteur.dart';

class IhmAuteur {
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Auteur");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IhmPrincipale.saisiChoix(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmAuteur.menuSelectAuteur(settings);
      } else if (choix == 2) {
        await IhmAuteur.insertAuteur(settings);
      } else if (choix == 3) {
        await IhmAuteur.updateAuteur(settings);
      } else if (choix == 4) {
        await IhmAuteur.deleteAuteur(settings);
      } else if (choix == 5) {
        await IhmAuteur.deleteAllAuteurs(settings);
      } else if (choix == 0) {
        print("Retour menu précédent.");
        await IhmPrincipale.afficherChoixTable(settings);
      }
    }
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectAuteur(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Auteur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IhmPrincipale.saisiChoix(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmAuteur.selectAuteur(settings);
      } else if (choix == 2) {
        await IhmAuteur.selectAllAuteurs(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un auteur
  static Future<void> insertAuteur(ConnectionSettings settings) async {
    String nom = IhmPrincipale.saisieString("le nom");
    String prenom = IhmPrincipale.saisieString("le prenom");
    await DbAuteur.insertAuteur(settings, nom, prenom);
    print("Auteur inséré dans la table.");
    print("--------------------------------------------------");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un auteur selon ID
  static Future<void> updateAuteur(ConnectionSettings settings) async {
    print("Quelle Auteur voulez vous mettre à jour ?");
    int id = IhmPrincipale.saisieID();
    if (await DbAuteur.exist(settings, id)) {
      String nom = IhmPrincipale.saisieString("le nom");
      String prenom = IhmPrincipale.saisieString("le prenom");
      await DbAuteur.updateAuteur(settings, id, nom, prenom);
      print("Auteur $id mis à jour.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'étudiant $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un auteur selon ID
  static Future<void> selectAuteur(ConnectionSettings settings) async {
    print("Quelle auteur voulez vous afficher ?");
    int id = IhmPrincipale.saisieID();
    Auteur auteur = await DbAuteur.selectAuteur(settings, id);
    if (!auteur.estNull()) {
      IhmPrincipale.afficherUneDonnee(auteur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'auteur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les auteur
  static Future<void> selectAllAuteurs(ConnectionSettings settings) async {
    List<Auteur> listeAuteur = await DbAuteur.selectAllAuteur(settings);
    if (listeAuteur.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeAuteur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer un auteur selon ID
  static Future<void> deleteAuteur(ConnectionSettings settings) async {
    print("Quelle auteur voulez vous supprimer ?");
    int id = IhmPrincipale.saisieID();
    DbAuteur.deleteAuteur(settings, id);
    print("Auteur $id supprimé.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour supprimer les auteurs
  static Future<void> deleteAllAuteurs(ConnectionSettings settings) async {
    DbAuteur.deleteAllAuteurs(settings);
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }
}
