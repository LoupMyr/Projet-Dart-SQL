import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'db_Config.dart';
import 'editeur.dart';

class DbEditeur {
  static Future<Editeur> selectEditeur(int id) async {
    Editeur edi = Editeur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Editeur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Editeur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        edi = Editeur(reponse.first['id'], reponse.first['nom'],
            reponse.first['adresse']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return edi;
  }

  static Future<List<Editeur>> selectAllEditeur() async {
    List<Editeur> listeEdi = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Editeur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Editeur edi = Editeur(row['id'], row['nom'], row['adresse']);
          listeEdi.add(edi);

          /*
          // variante avec création d'éditeur depuis une liste
          List<String> unEdi = [];
          for (var field in row) {
            unEdi.add(field.toString());
          }
          listeEdi.add(Editeur.fromListString(unEdi));
          */
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeEdi;
  }

  static Future<void> insertEditeur(String nom, String adresse) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "INSERT INTO Editeur (nom, adresse) VALUES('" +
            nom +
            "', '" +
            adresse +
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
  static Future<void> updateEditeur(int id, String nom, String adresse) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Editeur SET nom = '" +
            nom +
            ", adresse = '" +
            adresse +
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
  static Future<void> deleteEditeur(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Editeur WHERE id='" + id.toString() + "'";
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
  static Future<void> deleteAllEditeur() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "TRUNCATE TABLE Editeur;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un editeur selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    if (!(await DbEditeur.selectEditeur(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getAuteur
  static Future<Editeur> getEditeur(int id) async {
    dynamic r = await selectEditeur(id);
    ResultRow rr = r.first;
    return Editeur(rr['id'], rr['nom'], rr['adresse']);
  }
}
