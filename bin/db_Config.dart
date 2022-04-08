import 'dart:developer';

import 'package:mysql1/mysql1.dart';

class DBConfig {
  // Permet de créer des tables, en vérifiant si elles existes ou non
  // et créé les tables manquantes si besoin
  static Future<void> createTables(ConnectionSettings settings) async {
    bool checkProduit = false;
    bool checkAuteur = false;
    bool checkEditeur = false;

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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
        if (!checkEditeur) {
          requete =
              'CREATE TABLE Editeur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(255), adresse varchar(255));';
          await conn.query(requete);
        }
        if (!checkAuteur) {
          requete =
              'CREATE TABLE Auteur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(255), prenom varchar(255));';
          await conn.query(requete);
        }
        if (!checkProduit) {
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

  // Permet de retourner vrai si toute les tables sont créé, faux sinon
  static Future<bool> checkTables(ConnectionSettings settings) async {
    bool checkAll = false;
    bool checkProduit = false;
    bool checkAuteur = false;
    bool checkEditeur = false;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  // Permet de retourner la liste des noms des tables dans la BDD;
  static Future<List<String>> selectTables(ConnectionSettings settings) async {
    List<String> listTable = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  // Permet de supprimer une table via son nom passé en parametre, si elle existe dans la BDD
  static Future<void> dropTable(
      ConnectionSettings settings, String table) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  // Permet de supprimer toute les tables dans la BDD
  static Future<void> dropAllTable(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      bool checkProduit = false;
      bool checkAuteur = false;
      bool checkEditeur = false;
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields == "Auteur") {
              checkAuteur = true;
            } else if (fields == "Editeur") {
              checkEditeur = true;
            } else if (fields == "Produit") {
              checkProduit = true;
            }
          }
        }
        if (checkProduit) {
          await dropTable(settings, "Produit");
        }
        if (checkEditeur) {
          await dropTable(settings, "Editeur");
        }
        if (checkAuteur) {
          await dropTable(settings, "Auteur");
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<dynamic> executerRequete(
      ConnectionSettings settings, String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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
