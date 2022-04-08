import 'dart:io';
import 'package:mysql1/mysql1.dart';

import 'IHM_Auteur.dart';
import 'IHM_Editeur.dart';
import 'db_Config.dart';
import 'IHM_Produit.dart';
import 'data.dart';

class IhmPrincipale {
  // Permet d'afficher un message d'accueil
  static void afficherAccueil() {
    print(
        "\n\n\n\n#########################\n# GESTION FURET DU NORD #\n#########################\n");
  }

  // Permet de faire la saisie des choix (int) avec en paramètre le nombre de choix désiré
  static int saisiChoix(int nbchoix) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir une action (0-$nbchoix)");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i >= 0 && i <= nbchoix) {
          saisieValide = true;
        } else {
          print("La saisie ne correspond à aucune action.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // Permet de faire la saisie d'un entier avec en paramètre l'objectif de cette saisie
  static int saisiInt(String butSaisi) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir $butSaisi:");
      try {
        i = int.parse(stdin.readLineSync().toString());
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // Permet de faire la saisie d'un String avec en paramètre l'objectif de cette saisie
  static String saisieString(String butSaisi) {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir $butSaisi:");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  // Permet de faire la saisie d'un ID (int)
  static int saisieID() {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir l'id correspondant:");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i > 0) {
          saisieValide = true;
        } else {
          print("La valeur saisie est inférieur ou égale à zéro.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // Permet de faire la saisie d'un mot de passe (echoMode false)
  static String saisieMDP() {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir le mot de passe :");
      try {
        stdin.echoMode = false;
        s = stdin.readLineSync().toString();
        saisieValide = true;
        stdin.echoMode = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  // Permet de faire la saisie des paramètres pour la connexion à la BDD (db, user, mdp)
  static Future<ConnectionSettings> setting() async {
    bool valide = false;
    ConnectionSettings settings = ConnectionSettings(
      host: "localhost",
      port: 3306,
      user: "DartUser",
      password: "usermdp",
      db: "DartDB",
    );
    while (!valide) {
      String bdd = IhmPrincipale.saisieString("le nom de la BDD");
      String user = IhmPrincipale.saisieString("l'utilisateur");
      String mdp = IhmPrincipale.saisieMDP();
      ConnectionSettings settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: user, // DartUser
        password: mdp, // usermdp
        db: bdd, // DartDB
      );
      try {
        MySqlConnection conn = await MySqlConnection.connect(settings);
        conn.close();
        valide = true;
      } catch (e) {
        print("Problème lors de la connexion, veuillez recommencer.");
      }
    }
    return settings;
  }

  // Permet d'afficher la donnée placée en paramètre
  static void afficherUneDonnee(Data data) {
    print(data.getEntete());
    print(data.getInLine());
  }

  // Permet d'afficher les données placées en paramètre (List)
  static void afficherDesDonnees(List<Data> dataList) {
    print(dataList.first.getEntete());
    for (var Donnee in dataList) {
      print(Donnee.getInLine());
    }
  }

  // Permet d'afficher le menu des choix de la table sur laquelle on souhaite se rendre ou alors partir du programme
  static Future<void> afficherChoixTable(ConnectionSettings settings) async {
    int nb = -1;
    bool valide = false;
    while (nb != 0) {
      print(
          "\n\n#######################\n# CHOSISSEZ UNE OPTION #\n#######################\n\n");
      print("0. Annuler\n1. BDD\n2. Produit\n3. Auteur\n4. Editeur\n");
      int nb = saisiChoix(4);
      if (nb == 1) {
        await IhmPrincipale.menuBDD(settings);
      } else if (nb == 2) {
        await IhmProduit.menu(settings);
      } else if (nb == 3) {
        await IhmAuteur.menu(settings);
      } else if (nb == 4) {
        await IhmEditeur.menu(settings);
      } else if (nb == 0) {
        valide = true;
      }
    }
  }

  // Permet d'afficher le menu des possibilités d'actions sur la BDD
  static Future<void> menuBDD(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print(
          "\n\n#########################\n# CHOISISSEZ UNE ACTION #\n#########################\n\n");
      print(
          "0. Annuler\n1. Créer les tables\n2. Vérifier les tables\n3. Afficher les tables\n4. Supprimer une table\n5. Supprimer toutes les tables\n");
      int choix = saisiChoix(5);
      if (choix == 1) {
        await IhmPrincipale.createTable(settings);
      } else if (choix == 2) {
        await IhmPrincipale.checkTable(settings);
      } else if (choix == 3) {
        await IhmPrincipale.selectTables(settings);
      } else if (choix == 4) {
        await IhmPrincipale.deleteTable(settings);
      } else if (choix == 5) {
        await IhmPrincipale.deleteAllTables(settings);
      } else if (choix == 0) {
        print("Retour menu précédent.");
        await IhmPrincipale.afficherChoixTable(settings);
      }
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de lancer la méthode qui crée les tables manquantes dans la BDD
  static Future<void> createTable(ConnectionSettings settings) async {
    print("Création des tables manquantes dans la BDD ...");
    await DBConfig.createTables(settings);
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de lancer la méthode pour vérifier l'existence des tables dans la BDD
  static Future<void> checkTable(ConnectionSettings settings) async {
    print("Verification des tables dans la BDD ...");
    if (await DBConfig.checkTables(settings)) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de lancer la méthode d'affichage des tables dans la BDD
  static Future<void> selectTables(ConnectionSettings settings) async {
    List<String> listTable = await DBConfig.selectTables(settings);
    print("Liste des tables :");
    for (var table in listTable) {
      print("- $table");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de lancer la méthode de suppression d'une table précise en fonction de son nom
  static Future<void> deleteTable(ConnectionSettings settings) async {
    print("Quelle table voulez vous supprimer ?");
    String table = IhmPrincipale.saisieString("la table");
    DBConfig.dropTable(settings, table);
    print("Table supprimée.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet de lancer la méthode de suppression de toutes les tables de la BDD
  static Future<void> deleteAllTables(ConnectionSettings settings) async {
    DBConfig.dropAllTable(settings);
    print("Tables supprimées.");
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // Permet d'afficher un message d'au revoir
  static void goodbye() {
    print("\n\n#############\n# AU REVOIR #\n#############\n");
  }
}
