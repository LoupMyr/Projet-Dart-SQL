import 'dart:developer';

import 'package:mysql1/mysql1.dart';

class DBConfig {
  // attribut et méthode static, car pas besoin d'instanciation de la classe.
  static ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'DartUser',
    password: 'usermdp',
    db: "DartDB",
  );

  static ConnectionSettings getSettings() {
    return settings;
  }

  // permet la création des tables, en vérifiant si elles existes ou non
  // et créé les tables manquantes si besoin
  static Future<void> createTables() async {
    bool checkProduit = false;
    bool checkAuteur = false;
    bool checkEditeur = false;

    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Produit") {
              checkProduit = true;
            }
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
          }
        }
        if (!checkProduit) {
          requete =
              'CREATE TABLE Editeur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(255), adresse varchar(255));';
          await conn.query(requete);
        }
        if (!checkAuteur) {
          requete =
              'CREATE TABLE Auteur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(255), prenom varchar(255));';
          await conn.query(requete);
        }
        if (!checkEditeur) {
          requete =
              'CREATE TABLE Produit (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, titre varchar(255), type varchar(255), prix int, nbDispo int, auteur int, editeur int, foreign key c1 (auteur) references Auteur(id), foreign key c2 (editeur) references Editeur(id));';
          await conn.query(requete);
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // retourne vrai si toute les tables sont créé, faux sinon
  static Future<bool> checkTables() async {
    bool checkAll = false;
    bool checkProduit = false;
    bool checkAuteur = false;
    bool checkEditeur = false;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Produit") {
              checkProduit = true;
            }
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }

    if (checkProduit && checkAuteur && checkEditeur) {
      checkAll = true;
    }
    return checkAll;
  }

  // retourne la liste des noms des tables dans la BDD;
  static Future<List<String>> selectTables() async {
    List<String> listTable = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            listTable.add(fields);
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return listTable;
  }

  // permet de supprimer une table via son nom passé en parametre, si elle existe dans la database
  static Future<void> dropTable(String table) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        await conn.query("DROP TABLES IF EXISTS " + table + ";");
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // supprime toute les tables dans la DB
  static Future<void> dropAllTable() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<dynamic> executerRequete(String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return reponse;
  }
}
