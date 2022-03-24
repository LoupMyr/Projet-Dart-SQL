import 'dart:io';

import 'IHM_Auteur.dart';
import 'IHM_Editeur.dart';
import 'IHM_Produit.dart';

class IhmPrincipale {
  static void afficherAccueil() {
    print(
        "#########################\n# GESTION FURET DU NORD #\n#########################\n");
  }

  static Future<void> afficherChoixTable() async {
    int nb = -1;
    while (nb != 0) {
      print(
          "#######################\n# CHOSISSEZ UNE OPTION #\n#######################\n\n");
      print("1. BDD\n2. Produit\n3. Auteur\n4. Editeur\n5. Annuler\n");
      int nb = saisiChoixTable(5);
      if (nb == 1) {
        await IhmPrincipale.menuBDD();
      } else if (nb == 2) {
        await IhmProduit.menu();
      } else if (nb == 3) {
        await IhmAuteur.menu();
      } else if (nb == 4) {
        await IhmEditeur.menu();
      }
    }
  }

  static int saisiChoixTable(int nbchoix) {
    bool valide = false;
    int nb = 0;
    print("Entre 1 et " + nbchoix.toString());
    while (!valide) {
      try {
        int nb = int.parse(stdin.readLineSync().toString());
        if (nb >= 1 && nb <= nbchoix) {
          valide = true;
        }
      } catch (e) {
        print("Veuillez recommencer");
      }
    }
    return nb;
  }

  static Future<void> menuBDD() async {
    int choix = -1;
    while (choix != 0) {
      print(
          "#########################\n# CHOISISSEZ UNE ACTION #\n#########################\n\n");
      print(
          "1. Créer les tables\n2. Vérifier les tables\n3. Afficher les tables\n4. Supprimer une table\n5. Supprimer toutes les tables\n6. Annuler");
      int choix = saisiChoixTable(6);
      if (choix == 1) {
        await IhmPrincipale.createTable();
      } else if (choix == 2) {
        await IhmPrincipale.checkTable();
      } else if (choix == 3) {
        await IhmPrincipale.selectTable();
      } else if (choix == 4) {
        await IhmPrincipale.deleteTable();
      } else if (choix == 5) {
        await IhmPrincipale.deleteAllTables();
      }
    }
    print("Retour menu précédent.");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> createTable() async {
    print("Création des tables manquantes dans la BDD ...");
    await DBConfig.createTables();
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour vérifier les tables
  static Future<void> checkTable() async {
    print("Verification des tables dans la BDD ...");
    if (await DBConfig.checkTables()) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour afficher les tables
  static Future<void> selectTable() async {
    List<String> listTable = await DBConfig.selectTables();
    print("Liste des tables :");
    for (var table in listTable) {
      print("- $table");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer une table
  static Future<void> deleteTable() async {
    print("Quelle table voulez vous supprimer ?");
    String table = IhmPrincipale.saisieString();
    DBConfig.dropTable(table);
    print("Table supprimée.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
    print("Annulation de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer les tables
  static Future<void> deleteAllTables() async {
    DBConfig.dropAllTable();
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menu() async {
    print(
        "#########################\n# CHOISISSEZ UNE ACTION #\n#########################\n\n");
    print(
        "1. Selectionner\n2. Modifier\n3. Insérer\n4. Supprimer\n5. Annuler\n");
    saisiChoixTable(5);
  }

  static void goodbye() {
    print("\n#############\n# AU REVOIR #\n#############\n");
  }
}
