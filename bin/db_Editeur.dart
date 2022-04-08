import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'db_Config.dart';
import 'editeur.dart';

class DbEditeur {
  // Permet de sélectionner un éditeur précis selon son ID
  static Future<Editeur> selectEditeur(
      ConnectionSettings settings, int id) async {
    Editeur edi = Editeur.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  // Permet de sélectionner tous les éditeurs
  static Future<List<Editeur>> selectAllEditeurs(
      ConnectionSettings settings) async {
    List<Editeur> listeEdi = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Editeur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Editeur edi = Editeur(row['id'], row['nom'], row['adresse']);
          listeEdi.add(edi);
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

  // Permet d'insérer un éditeur dans la table
  static Future<void> insertEditeur(
      ConnectionSettings settings, String nom, String adresse) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  //Permet de modifier un éditeur de la table selon son ID
  static Future<void> updateEditeur(
      ConnectionSettings settings, int id, String nom, String adresse) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Editeur SET nom = '" +
            nom +
            "', adresse = '" +
            adresse +
            " ' WHERE id='" +
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

  //Permet de supprimer un éditeur dans la table selon son ID
  static Future<void> deleteEditeur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  //Permet de supprimer tous les éditeurs
  static Future<void> deleteAllEditeur(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Editeur;";
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
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DbEditeur.selectEditeur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // récupére un éditeur
  static Future<Editeur> getEditeur(ConnectionSettings settings, int id) async {
    dynamic r = await selectEditeur(settings, id);
    ResultRow rr = r.first;
    return Editeur(rr['id'], rr['nom'], rr['adresse']);
  }
}
