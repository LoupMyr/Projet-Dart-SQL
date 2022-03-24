import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'auteur.dart';
import 'db_Config.dart';

class DbAuteur {
  static Future<Auteur> selectAuteur(int id) async {
    Auteur aut = Auteur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Auteur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Auteur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        aut = Auteur(
            reponse.first['id'], reponse.first['nom'], reponse.first['prenom']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return aut;
  }

  static Future<List<Auteur>> selectAllAuteur() async {
    List<Auteur> listeAut = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Auteur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Auteur aut = Auteur(row['id'], row['nom'], row['prenom']);
          listeAut.add(aut);

          /*
          // variante avec création d'auteur depuis une liste
          List<String> unAut = [];
          for (var field in row) {
            unAut.add(field.toString());
          }
          listeAut.add(Auteur.fromListString(unAut));
          */
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeAut;
  }

  static Future<void> insertAuteur(String nom, String prenom) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "INSERT INTO Auteur (nom, prenom) VALUES('" +
            nom +
            "', '" +
            prenom +
            "');";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //update
  static Future<void> updateAuteur(int id, String nom, String prenom) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Auteur SET nom = '" +
            nom +
            ", prenom = '" +
            prenom +
            ", ' WHERE id='" +
            id.toString() +
            "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete
  static Future<void> deleteAuteur(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Auteur WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete all
  static Future<void> deleteAllAuteurs() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "TRUNCATE TABLE Auteur;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un auteur selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    if (!(await DbAuteur.selectAuteur(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getAuteur
  static Future<Auteur> getAuteur(int id) async {
    dynamic r = await selectAuteur(id);
    ResultRow rr = r.first;
    return Auteur(rr['id'], rr['nom'], rr['prenom']);
  }
}
