import 'package:mysql1/mysql1.dart';

import 'db_Editeur.dart';
import 'db_Produit.dart';
import 'editeur.dart';
import 'IHM_P.dart';
import 'produit.dart';

class IhmProduit {
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
        await IhmProduit.menuSelectPro(settings);
      } else if (choix == 2) {
        await IhmProduit.insertProduit(settings);
      } else if (choix == 3) {
        await IhmProduit.updateProduit(settings);
      } else if (choix == 4) {
        await IhmProduit.deleteProduit(settings);
      } else if (choix == 5) {
        await IhmProduit.deleteAllProduits(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  static Future<void> menuSelectPro(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Editeur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("3- Afficher les produits selon l'ID de l'auteur");
      print("4- Afficher les produits selon l'ID de l'éditeur");
      print("0- Quitter");
      choix = IhmPrincipale.saisiChoix(4);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IhmProduit.selectProduit(settings);
      } else if (choix == 2) {
        await IhmProduit.selectAllProduits(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour ajouter un produit
  static Future<void> insertProduit(ConnectionSettings settings) async {
    String titre = IhmPrincipale.saisieString("le titre");
    int idAuteur = IhmPrincipale.saisiInt("l'id de l'auteur");
    int idEditeur = IhmPrincipale.saisiInt("l'id de l'éditeur");
    String type = IhmPrincipale.saisieString("le type");
    int prix = IhmPrincipale.saisiInt("le prix");
    int nbDispo = IhmPrincipale.saisiInt("le nombre de dispo");

    await DbProduit.insertProduit(
        settings, titre, idAuteur, idEditeur, type, prix, nbDispo);
    print("Editeur inséré dans la table.");
    print("--------------------------------------------------");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour mettre a jour un Editeur selon ID
  static Future<void> updateProduit(ConnectionSettings settings) async {
    print("Quelle Produit voulez vous mettre à jour ?");
    int id = IhmPrincipale.saisieID();
    if (await DbProduit.exist(settings, id)) {
      String titre = IhmPrincipale.saisieString("le titre");
      int idAuteur = IhmPrincipale.saisiInt("l'id de l'auteur");
      int idEditeur = IhmPrincipale.saisiInt("l'id de l'éditeur");
      String type = IhmPrincipale.saisieString("le type");
      int prix = IhmPrincipale.saisiInt("le prix");
      int nbDispo = IhmPrincipale.saisiInt("le nombre de dispo");
      await DbProduit.updateProduit(
          settings, id, titre, idAuteur, idEditeur, type, prix, nbDispo);
      print("Produit $id mis à jour.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Le produit $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 2));
    }
  }

  // action pour afficher un Editeur selon ID
  static Future<void> selectProduit(ConnectionSettings settings) async {
    print("Quelle produit voulez vous afficher ?");
    int id = IhmPrincipale.saisieID();
    Produit produit = await DbProduit.selectProduit(settings, id);
    if (!produit.estNull()) {
      IhmPrincipale.afficherUneDonnee(produit);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("Le produit $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 2));
  }

  static Future<void> selectAuteur(ConnectionSettings settings) async {
    String requete = IhmPrincipale.saisieString("l'id de l'auteur");
    DbProduit.selectAuteur(settings, id);
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> selectEditeur(ConnectionSettings settings) async {
    String requete = IhmPrincipale.saisieString("l'id de l'éditeur");
    DbProduit.selectEditeur(settings, id);
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les produits
  static Future<void> selectAllProduits(ConnectionSettings settings) async {
    List<Produit> listeProduit = await DbProduit.selectAllProduits(settings);
    if (listeProduit.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeProduit);
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
  static Future<void> deleteProduit(ConnectionSettings settings) async {
    print("Quel Produit voulez vous supprimer ?");
    int id = IhmPrincipale.saisieID();
    DbProduit.deleteProduit(settings, id);
    print("Produit $id supprimé.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }

  // action pour supprimer les Editeur
  static Future<void> deleteAllProduits(ConnectionSettings settings) async {
    DbProduit.deleteAllProduit(settings);
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 2));
  }
}
